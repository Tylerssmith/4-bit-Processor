`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: BYU-Idaho
// Engineer: Shane Jensen, Joseph Hawker
// 
// Create Date: 3/23/2016
// Design Name: 
// Module Name: 7segment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 1.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sevenSegment(
    input [7:0] char,
    input charWE, clk, clk100MHz, clr,
    output wire [6:0] seg,
    output reg [3:0] an,
    output wire dp
    );
    reg [31:0] data;
    reg [19:0] clkDiv;
    reg [7:0] segdp, digit;
    wire [1:0] dispSel;
    
    assign dispSel = clkDiv[19:18];
    assign {dp, seg} = segdp;
    initial data <= 32'h00000000; // null characters for initial blank screen
    
    // handle the meta characters in addition to the normal ones
    always @(posedge clk or posedge clr) 
    begin
        if (clr)
            data = 32'h00000000;
        else
            begin
                if (charWE) case (char)
                // <backspace>, <delete> - puts a null character in front of the others
                'h08,'h7F: data = {8'h00, data[31:8]};
                // <line feed>, <vertical tab>, <form feed>, <carriage return> - clears the screen
                'h0A,'h0B,'h0C,'h0D: data = 32'h00000000;
                // <tab> - inserts two blanks instead of just one
                'h09: data = {data[15:0], char, char};
                default: data = {data[23:0], char};
                endcase
            end
    end

    // refresh each display for a 1/4 of the time
    always @(posedge clk100MHz) begin
        case (dispSel)
            0:digit = data[7:0];
            1:digit = data[15:8];
            2:digit = data[23:16];
            3:digit = data[31:24];
        endcase
        clkDiv = clkDiv + 1; // clock cycle counter/divider
    end
    
    // ASCII decoder
    always @(*) begin
        case (digit)
            ////////////////////////////////////////////////
            // 7seg BINARY KEY               -a-          \\
            //                             f|   |b        //
            //                               -g-          \\
            //          MSB <---- LSB      e|   |c        //
            //           <dp>gfedcba         -d-  .dp     \\
            ////////////////////////////////////////////////
            'h00:segdp = 8'b11111111; // <null>
            
          //'h08 - meta <backspace>
            'h09:segdp = 8'b11111111; // meta/normal <tab>
          //'h0A,'h0B,'h0C,'h0D - meta <line feed>/<vertical tab>/<form feed>/<carriage return>
            
            'h20:segdp = 8'b11111111; // <space>
            'h21:segdp = 8'b01111101; // !
            'h22:segdp = 8'b11011101; // "
            
            'h27:segdp = 8'b11111101; // '
            'h28:segdp = 8'b01000110; // (
            'h29:segdp = 8'b01110000; // )
            'h2A:segdp = 8'b10011100; // *
            'h2B:segdp = 8'b10111001; // +
            'h2C:segdp = 8'b11111011; // ,
            'h2D:segdp = 8'b10111111; // -
            'h2E:segdp = 8'b01111111; // .
            'h2F:segdp = 8'b10101101; // /
            
            'h30:segdp = 8'b11000000; // 0
            'h31:segdp = 8'b11111001; // 1
            'h32:segdp = 8'b10100100; // 2
            'h33:segdp = 8'b10110000; // 3
            'h34:segdp = 8'b10011001; // 4
            'h35:segdp = 8'b10010010; // 5
            'h36:segdp = 8'b10000010; // 6
            'h37:segdp = 8'b11111000; // 7
            'h38:segdp = 8'b10000000; // 8
            'h39:segdp = 8'b10010000; // 9
            
            'h3C:segdp = 8'b10011111; // <
            'h3D:segdp = 8'b10111110; // =
            'h3E:segdp = 8'b10111101; // >
            'h3F:segdp = 8'b10101100; // ?
            'h40:segdp = 8'b00000100; // @ (sort of)
            
            'h41,'h61:segdp = 8'b10001000; // Aa
            'h42,'h62:segdp = 8'b10000011; // Bb
            'h43,'h63:segdp = 8'b10100111; // Cc
            'h44,'h64:segdp = 8'b10100001; // Dd
            'h45,'h65:segdp = 8'b10000110; // Ee
            'h46,'h66:segdp = 8'b10001110; // Ff
            'h47,'h67:segdp = 8'b00010000; // Gg
            'h48,'h68:segdp = 8'b10001011; // Hh
            'h49,'h69:segdp = 8'b11001111; // Ii
            'h4A,'h6A:segdp = 8'b11100001; // Jj
            'h4B,'h6B:segdp = 8'b00001101; // Kk
            'h4C,'h6C:segdp = 8'b11000111; // Ll
            'h4D,'h6D:segdp = 8'b11101010; // Mm (sort of)
            'h4E,'h6E:segdp = 8'b10101011; // Nn
            'h4F,'h6F:segdp = 8'b10100011; // Oo
            'h50,'h70:segdp = 8'b10001100; // Pp
            'h51,'h71:segdp = 8'b00011000; // Qq
            'h52,'h72:segdp = 8'b10101111; // Rr
            'h53,'h73:segdp = 8'b00010010; // Ss
            'h54,'h74:segdp = 8'b10000111; // Tt
            'h55,'h75:segdp = 8'b11000001; // Uu
            'h56,'h76:segdp = 8'b11100011; // Vv
            'h57,'h77:segdp = 8'b11010101; // Ww (sort of)
            'h58,'h78:segdp = 8'b00001001; // Xx
            'h59,'h79:segdp = 8'b10010001; // Yy
            'h5A,'h7A:segdp = 8'b00100100; // Zz
            
            'h5B:segdp = 8'b01000110; // [
            'h5C:segdp = 8'b10011011; // \
            'h5D:segdp = 8'b01110000; // ]
            'h5E:segdp = 8'b11011110; // ^
            'h5F:segdp = 8'b11110111; // _
            'h60:segdp = 8'b11011111; // `
            
            'h7B:segdp = 8'b00000110; // {
            'h7C:segdp = 8'b01001111; // |
            'h7D:segdp = 8'b00110000; // }
            'h7E:segdp = 8'b00101101; // ~
          //'h7F - meta <delete>
            
            // for easier development of char patterns
            'hFF:segdp = char;
            
            default:segdp = 8'b00110101; // invalid/unknown character
        endcase
        
        // select the physical display that we are sending data to
        an = 4'b1111;
        an[dispSel] = 0;
    end
endmodule
