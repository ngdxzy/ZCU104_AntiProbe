`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2019 07:37:49 PM
// Design Name: 
// Module Name: AXI_Interface
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ns

module AXI_Interface #(
    parameter ADDR_WIDTH       = 10,                
    parameter DATA_WIDTH       = 16,
    parameter S_AXI_ADDR_WIDTH     = 32,               
    parameter S_AXI_DATA_WIDTH     = 32
)(

    //--------------  AXI Interface Signals         --------------
    input                             S_AXI_aclk,
    input                             S_AXI_aresetn,

    input  [S_AXI_ADDR_WIDTH-1:0]                   S_AXI_araddr,
    output reg                        S_AXI_arready,
    input                             S_AXI_arvalid,
    input  [2:0]                      S_AXI_arprot,

    input [S_AXI_ADDR_WIDTH-1:0]                    S_AXI_awaddr,
    output reg                        S_AXI_awready,
    input                             S_AXI_awvalid,
    input  [2:0]                      S_AXI_awprot,

    output  [1:0]                  S_AXI_bresp,  
    input                             S_AXI_bready,
    output reg                        S_AXI_bvalid,

    output reg [S_AXI_DATA_WIDTH-1:0] S_AXI_rdata,
    input                             S_AXI_rready,
    output reg                        S_AXI_rvalid,
    output  [1:0]                  S_AXI_rresp,

    input  [S_AXI_DATA_WIDTH-1:0]     S_AXI_wdata,
    output                         S_AXI_wready,
    input                             S_AXI_wvalid,
    input  [S_AXI_DATA_WIDTH/8-1:0]   S_AXI_wstrb,

    //-------------- Dynamic Reconfiguration Port (DRP) --------------
    output reg [ADDR_WIDTH-1:0] w_addr,
    output reg [ADDR_WIDTH-1:0] r_addr,
    output reg [DATA_WIDTH-1:0] w_data,
    input [DATA_WIDTH-1:0] r_data,
    output reg w_occur,
    output reg r_occur,
    input w_ready,
    input r_valid
); // drp_bridge
        

	//AW
    always @ (posedge S_AXI_aclk or negedge S_AXI_aresetn) begin
        if(!S_AXI_aresetn) begin
            w_addr <= {ADDR_WIDTH{1'b0}};
        end
        else if(S_AXI_awvalid & (~S_AXI_awready)) begin
            w_addr <= S_AXI_awaddr[ADDR_WIDTH + 1:2];
        end
    end

    always @ (posedge S_AXI_aclk or negedge S_AXI_aresetn) begin
        if(~S_AXI_aresetn) begin
            S_AXI_awready <= 1'b0;
        end
        else begin
            if(S_AXI_awvalid && (~S_AXI_awready) && S_AXI_wvalid) begin
                S_AXI_awready <= 1;
            end
            else begin
                S_AXI_awready <= 0;
            end
        end
    end

    //W Channel
    assign S_AXI_wready = w_ready;

    always @ (posedge S_AXI_aclk or negedge S_AXI_aresetn) begin
        if(~S_AXI_aresetn) begin
            w_data <= 'b0;
        end
        else begin
            if(S_AXI_wvalid && S_AXI_awvalid && (~S_AXI_awready)) begin
                w_data <= S_AXI_wdata[DATA_WIDTH-1:0];
            end
            else begin
                w_data <= w_data;
            end
        end
    end

    //wrsp channel
    assign S_AXI_bresp = 2'b00;
    always @ (posedge S_AXI_aclk or negedge S_AXI_aresetn) begin
        if(~S_AXI_aresetn) begin
            S_AXI_bvalid <= 0;
        end
        else begin
            if(w_ready && (~S_AXI_bvalid)) begin
                S_AXI_bvalid <= 1'b1;
            end
            else begin
                if(S_AXI_bvalid && S_AXI_bready) begin
                    S_AXI_bvalid <= 1'b0;
                end
            end
        end
    end

    //AR channel
	always @ (posedge S_AXI_aclk or negedge S_AXI_aresetn) begin
        if(!S_AXI_aresetn) begin
           r_addr <= {ADDR_WIDTH{1'b0}};
        end
        else if(S_AXI_arvalid & (~S_AXI_arready)) begin
            r_addr <= S_AXI_araddr[ADDR_WIDTH + 1:2];
        end
    end

    always @ (posedge S_AXI_aclk or negedge S_AXI_aresetn) begin
        if(~S_AXI_aresetn) begin
            S_AXI_arready <= 1'b0;
        end
        else begin
            if(S_AXI_arvalid && (~S_AXI_arready)) begin
                S_AXI_arready <= 1;
            end
            else begin
                S_AXI_arready <= 0;
            end
        end
    end

    //R Channel
    assign S_AXI_rresp = 2'b00;
    always @ (posedge S_AXI_aclk or negedge S_AXI_aresetn) begin
        if(~S_AXI_aresetn) begin
            S_AXI_rdata <= 'b0;
            S_AXI_rvalid <= 1'b0;
        end
        else begin
            if(r_valid && (~S_AXI_rvalid)) begin
                S_AXI_rdata <= {'b0,r_data};
                S_AXI_rvalid <= 1'b1;
            end
            else if(S_AXI_rvalid && S_AXI_rready) begin
                S_AXI_rdata <= S_AXI_rdata;
                S_AXI_rvalid <= 1'b0;
            end
        end
    end
    //
    //en 

    always @ (posedge S_AXI_aclk or negedge S_AXI_aresetn) begin
        if(~S_AXI_aresetn) begin
            r_occur <= 0;
            w_occur <= 0;
        end
        else begin
            if(S_AXI_arvalid && (~S_AXI_arready)) begin
                r_occur <= 1;
            end
            else begin
                r_occur <= 0;
            end
            if(S_AXI_awvalid && (~S_AXI_awready) && S_AXI_wvalid) begin               
                w_occur <= 1;
            end
            else begin
                w_occur <= 0;
            end
        end
    end
endmodule
