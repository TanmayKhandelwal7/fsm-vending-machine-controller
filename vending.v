`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2026 19:18:24
// Design Name: 
// Module Name: vending
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


module vending(
input clk,reset,
input [1:0]C10,C20,
input PA,PB,PC,
output reg [6:0]CA,
output reg CI,IBI,DA,DB,DC,
output wire [1:0]s,
output [4:0]val,cost
);

reg[1:0]state,next_state;

wire check;
parameter S0 =2'd0,S1=2'd1,S2=2'd2;
wire coin,product;
assign val = C10*2'd2 + C20*3'd4;
assign cost = PA?5'd2:PB?5'd3:PC?5'd4:5'd0;
assign coin = C10[0]|C10[1]|C20[0]|C20[1];
assign product  = PA|PB|PC;
assign check = (val<cost)?1'd1:1'd0;


always@(*) begin
case(state) 
S0:begin
  if(coin) next_state<=S1;
  else next_state<=S0;
  end
S1:begin
  if(product) next_state<=S2;
  else next_state<=S1;
  end
S2: begin
   if(~product & ~coin) next_state<=S0;
   else next_state<=S2;
   end
   
   endcase
   end
   
   
   always@(posedge clk or posedge reset)begin
   if(reset) begin
   state<=S0;
   DA<=1'd0;
   DB<=1'd0;
   DC<=1'd0;
   IBI<=1'd0;
   CA<=5'd0;
   CI<=1'd0;
   end
   
   else state<=next_state;
   end
   always @(*)begin
   case(state)
   S0:begin
   DA=1'd0;
   DB=1'd0;
   DC=1'd0;
   IBI=1'd0;
   CA=5'd0;
   CI=1'd0;
   end
   S1:begin
   DA=1'd0;
   DB=1'd0;
   DC=1'd0;
   IBI=1'd0;
   CA=5'd0;
   CI=1'd0;
   end
   S2:begin
   DA=PA&~check;
   DB=PB&~check;
   DC=PC&~check;
   IBI=check;
   CA=(val - (cost&({5{~check}})))*3'd5;
   CI=|(val - cost);
   end
   
   endcase
   end
   
   endmodule
   
    
  