`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Joseph Hawker
// 
// Module Name: Program_ROM
// Project Name: ECEN 160L CPU
// Tool Versions: 
// Description: A ROM containing the program in machine code for the CPU designed
//              in ECEN 160L
//
// Revision: 1.00
// Revision 1.00 - Program completed
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module Program_ROM( input [6:0] count, output [3:0] opcode, data );
    
    reg [7:0] operation;
    
    assign {opcode, data} = operation;
    
    always @ (*) begin
        case (count)
              0: operation <= 8'h14;
              1: operation <= 8'h28;
              2: operation <= 8'h30;
              3: operation <= 8'h29;
              4: operation <= 8'h30;
              5: operation <= 8'h12;
              6: operation <= 8'h2c;
              7: operation <= 8'h30;
              8: operation <= 8'h20;
              9: operation <= 8'h30;
             10: operation <= 8'h14;
             11: operation <= 8'h22;
             12: operation <= 8'h30;
             13: operation <= 8'h2a;
             14: operation <= 8'h30;
             15: operation <= 8'h12;
             16: operation <= 8'h20;
             17: operation <= 8'h30;
             18: operation <= 8'h13;
             19: operation <= 8'h23;
             20: operation <= 8'h30;
             21: operation <= 8'h12;
             22: operation <= 8'h2b;
             23: operation <= 8'h30;
             24: operation <= 8'h13;
             25: operation <= 8'h24;
             26: operation <= 8'h30;
             27: operation <= 8'h2d;
             28: operation <= 8'h30;
             29: operation <= 8'h24;
             30: operation <= 8'h60;
             31: operation <= 8'h50;
             32: operation <= 8'h30;
             33: operation <= 8'h12;
             34: operation <= 8'h20;
             35: operation <= 8'h30;
             36: operation <= 8'h13;
             37: operation <= 8'h23;
             38: operation <= 8'h30;
             39: operation <= 8'h12;
             40: operation <= 8'h2a;
             41: operation <= 8'h30;
             42: operation <= 8'h13;
             43: operation <= 8'h23;
             44: operation <= 8'h30;
             45: operation <= 8'h2d;
             46: operation <= 8'h30;
             47: operation <= 8'h23;
             48: operation <= 8'h60;
             49: operation <= 8'h50;
             50: operation <= 8'h60;
             51: operation <= 8'h50;
             52: operation <= 8'h30;
             53: operation <= 8'h12;
             54: operation <= 8'h20;
             55: operation <= 8'h30;
             56: operation <= 8'h13;
             57: operation <= 8'h24;
             58: operation <= 8'h30;
             59: operation <= 8'h12;
             60: operation <= 8'h2d;
             61: operation <= 8'h30;
             62: operation <= 8'h13;
             63: operation <= 8'h23;
             64: operation <= 8'h30;
             65: operation <= 8'h2d;
             66: operation <= 8'h30;
             
             67: operation <= 8'h2f;
             68: operation <= 8'h90;
             69: operation <= 8'h50;
             70: operation <= 8'h11;
             71: operation <= 8'h60;
             72: operation <= 8'h50;
             73: operation <= 8'h14;
             74: operation <= 8'h60;
             75: operation <= 8'h50;
             76: operation <= 8'h13;
             77: operation <= 8'h30;
             
             78: operation <= 8'h00;
             79: operation <= 8'h00;
             80: operation <= 8'h00;
             81: operation <= 8'h00;
             82: operation <= 8'h00;
             83: operation <= 8'h00;
             84: operation <= 8'h00;
             85: operation <= 8'h00;
             86: operation <= 8'h00;
             87: operation <= 8'h00;
             88: operation <= 8'h00;
             89: operation <= 8'h00;
             90: operation <= 8'h00;
             91: operation <= 8'h00;
             92: operation <= 8'h00;
             93: operation <= 8'h00;
             94: operation <= 8'h00;
             95: operation <= 8'h00;
             96: operation <= 8'h00;
             97: operation <= 8'h00;
             98: operation <= 8'h00;
             99: operation <= 8'h00;
            100: operation <= 8'h00;
            101: operation <= 8'h00;
            102: operation <= 8'h00;
            103: operation <= 8'h00;
            104: operation <= 8'h00;
            105: operation <= 8'h00;
            106: operation <= 8'h00;
            107: operation <= 8'h00;
            108: operation <= 8'h00;
            109: operation <= 8'h00;
            110: operation <= 8'h00;
            111: operation <= 8'h00;
            112: operation <= 8'h00;
            113: operation <= 8'h00;
            114: operation <= 8'h00;
            115: operation <= 8'h00;
            116: operation <= 8'h00;
            117: operation <= 8'h00;
            118: operation <= 8'h00;
            119: operation <= 8'h00;
            120: operation <= 8'h00;
            121: operation <= 8'h00;      
            122: operation <= 8'h00;
            123: operation <= 8'h00;
            124: operation <= 8'h00;
            125: operation <= 8'h00;
            126: operation <= 8'h00;
            127: operation <= 8'h00;
            default operation <= 8'h00;
        endcase
    end
    
endmodule
