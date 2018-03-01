`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 
// Company: Brigham Young University - Idaho
// 
// Module Name: Instruction_Decoder
// Project Name: ECEN 160L CPU
// Target Devices: Basys 3, Nexys 4 DDR
// Tool Versions: Vivado 2015.4
// Description: An instruction decoder for the CPU design for ECEN 160L
// 
// Revision: 1.0 - Some renaming of signals
// Revision 0.50 - Blank module completed
// Revision 0.01 - File created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Decoder( input [3:0] opcode,
            output [2:0] aluFuncSel,
            output accumWE, regSourceSel, dispWE, regWrAddr, regWE);
    
    reg [7:0] data;
    
    assign {aluFuncSel, accumWE, regSourceSel, dispWE, regWrAddr, regWE} = data;
    
    always @ (*) begin
        case (opcode)
    		0: data <= 8'h00;
            1: data <= 8'h01;
            2: data <= 8'h03;
            3: data <= 8'h04;
            4: data <= 8'h09;
            5: data <= 8'h0b;
            6: data <= 8'h10;
            7: data <= 8'h50;
            8: data <= 8'h30;
            9: data <= 8'h70;
           10: data <= 8'h90;
           11: data <= 8'h00;
           12: data <= 8'h00;
           13: data <= 8'h00;
           14: data <= 8'h00;
           15: data <= 8'h00;
           default data <= 8'h00;
        endcase
    end
    
endmodule
