`timescale 1ns / 1ps

module vending_test(); 

    
    reg clk, PA, PB, PC, RESET;
    reg [1:0] C10, C20;
    wire DA, DB, DC, CI, IBI;
    wire [6:0] CA;
    
    vending ob (clk, RESET, C10, C20, PA, PB, PC, CA, CI, IBI, DA, DB, DC);
  
    initial begin 
        $monitor("Time=%0t | PA:%b PB:%b PC:%b | DA:%b DB:%b DC:%b | CI:%b CA:%b IBI:%b", 
                 $time, PA, PB, PC, DA, DB, DC, CI, CA, IBI);
    end

    initial begin 
        clk = 1'b0;
        forever #5 clk = ~clk;  
    end
    initial begin 
        RESET=1'b1; PA=1'b0; PB=1'b0; PC=1'b0; C10=2'b00; C20=2'b00;
        
        #15 RESET=1'b0; 
        
        #10 C10=2'b01; C20=2'b01;
        #10 PA=1'b1; PB=1'b0; PC=1'b0;     
        #20 C10 = 2'd0; C20 = 2'd0; PA = 1'd0; PB = 1'd0; PC = 1'd0; 
        
        #20 C10=2'b00; C20=2'b10;
        #30 PA=1'b0; PB=1'b0; PC=1'b1;      
        #20 C10 = 2'd0; C20 = 2'd0; PA = 1'd0; PB = 1'd0; PC = 1'd0; 
        
         #20 C10=2'b01; C20=2'b00;
        #30 PA=1'b0; PB=1'b0; PC=1'b1;      
        #20 C10 = 2'd0; C20 = 2'd0; PA = 1'd0; PB = 1'd0; PC = 1'd0; 
        
         #20 C10=2'b01; C20=2'b00;
        #30 PA=1'b1; PB=1'b0; PC=1'b0;      
        #20 C10 = 2'd0; C20 = 2'd0; PA = 1'd0; PB = 1'd0; PC = 1'd0;
        
         #20 C10=2'b11; C20=2'b11;
        #30 PA=1'b1; PB=1'b0; PC=1'b0;      
        #20 C10 = 2'd0; C20 = 2'd0; PA = 1'd0; PB = 1'd0; PC = 1'd0;
        #20 $stop; 
    end

endmodule