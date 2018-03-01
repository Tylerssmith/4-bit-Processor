`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University:  BYU-Idaho 
// Engineer: Shane Jensen, Joseph Hawker, Brother Jones
// 
// Create Date: 12/1/2015
// Design Name: Final project template for ECEN 160L
// Module Name: finalProject
// Project Name: 
// Target Devices: Basys 3 FPGA board
// 
// Dependencies: 
// 
// Revision:
// Revision 2.00 - 3/23/16 - Modified to use Program_ROM and Instruction_Decoder
//                           modules.
// Revision 1.00 - File Created
// Additional Comments:
//     Students may use the modules supplied with this project to do their own
//     designs, or may use this by filling in the "..." sections with appropriate
//     Verilog code and editing the Instruction_Decoder and Program_ROM modules.
//
//     Requirements for the project are given in a Final Project handout.
//
//     See comments in the code below and the .v files for more details.
// 
//////////////////////////////////////////////////////////////////////////////////

module finalProject(
    input clk,             // Push button for single stepping processor - button R
    input clr,           // Push button for asynchronous reset - button U
    input [2:0] clkSpeed,  // Lower three switches determine clock to use
    input clk100MHz,       // The 100 MHz on-board clock
    output [6:0] seg,      // Outputs to use the seven segment displays
    output [3:0] an,
    output dp,
    output reg [15:0] led
    );
    
    // Wires, busses and registers 
    
    reg  [26:0] clkDiv;        // A 27 bit counter to divide down the 100 MHz
    reg  clock;    
    
   
 

    // Debounce the single step push button clock input
    debouncer DB0(clk100MHz, 1'b0, clk, deBncClk);

    // Use the counter to divide down the 100 MHz clock
    always @(posedge clk100MHz) 
        clkDiv <= clkDiv + 1;

    // Select the clock speed to use for the CPU, based on the three lower switches.
    // When all switches are off, select the pushbutton switch.
    always @(*)
      case(clkSpeed)
        0: clock = deBncClk;
        1: clock = clkDiv[26];
        2: clock = clkDiv[25];
        3: clock = clkDiv[24];
        4: clock = clkDiv[23];
        5: clock = clkDiv[22];
        6: clock = clkDiv[21];
        7: clock = clkDiv[20];
      endcase


    
 
    // Counter
        reg [6:0] count;
        wire [6:0] cntToPROM;
        assign cntToPROM = count;
        wire [3:0] pDataToReg;
        assign pDataToReg = data;
        wire [3:0] opcodeToID;
        wire [3:0] opcode;
        assign opcodeToID = opcode;
        wire [2:0] funcSelToALU, aluFuncSel;
        assign funcSelToALU = aluFuncSel;
        wire aWEToAccum, regSelToReg, dispWEToDisp, regAddrToReg, regWEToReg;
        assign aWEToAccum = accumWE;
        assign regSelToReg = regSourceSel;
        assign dispWEToDisp = dispWE;
        assign regAddrToReg = regWrAddr;
        assign regWEToReg = regWE;
     //   reg [3:0] r0DataIn;
      //  reg [3:0] r1DataIn;
        wire [3:0] r0Data;
        wire [3:0] r1Data;
        wire [3:0] aDataToReg;
        assign aDataToReg = aData;
        wire [3:0] data, aData;
        wire [3:0] reg0ToLED, reg1ToLED;
        assign reg0ToLED = r0Data;
        assign reg1ToLED = r1Data;
        
        always @(*)
            begin
                led <= {count, 1'b0, reg0ToLED, reg1ToLED};
            end
   
    // Instantiate the program ROM, decoder ROM, ALU and display interface
    Program_ROM PRGROM(cntToPROM, opcode, data);
    Instruction_Decoder  DECODERROM(opcodeToID, aluFuncSel, accumWE, regSourceSel, dispWE, regWrAddr, regWE);
    alu ALU(r0Data, r1Data, aWEToAccum, funcSelToALU, clock, clr, aData);
    sevenSegment SEVSEG({r0Data, r1Data}, dispWEToDisp, clock, clk100MHz, clr, seg, an, dp);  
  //  reg4bit r0(clock, regWE, r0DataIn, r0Data );
   // reg4bit r1(clock, regWE, r1DataIn, r1Data );  
    
        
        always @(posedge clock or posedge clr)
        begin
            if (clr)
                count <= 7'h00;
            else
                count <= count + 1;
        end
        
        //RegFile
        
        
        reg [3:0] rg [1:0];
        
        initial
            begin
                rg[0] = 4'b0000;
                rg[1] = 4'b0000;
            end
        assign r0Data = rg[0];
        assign r1Data = rg[1]; 
        
        always @(posedge clock or posedge clr)
        begin
            if (clr)
                begin
                    rg[0] <= 4'h00;
                    rg[1] <= 4'h00;
                end
            else if (regWE)
                begin
                    if(~regSourceSel)
                        rg[regWrAddr] <= pDataToReg;
                    else if(regSourceSel)
                        rg[regWrAddr] <= aDataToReg;
                end

        end

    
endmodule
 

   //  Combinational logic for ALU
module  alu(
    input [3:0] r0Data,
    input [3:0] r1Data,
    input accumWE,
    input [2:0] aluFuncSel,
    input clock,
    input clr,
    output [3:0] aData
    ); 
    
    reg [3:0] comp;
    assign aData = comp;
    //reg4bit accum(clock, accumWE, comp, aData);
    
    always @(posedge clock or posedge clr)
           begin
               if (clr)
                       comp <= 4'h00;
               else if (accumWE)
                   begin
                        if (aluFuncSel == 2'b00)
                            comp <= r0Data + r1Data;
                        else if (aluFuncSel == 2'b01)
                            comp <= r0Data | r1Data;
                        else if (aluFuncSel == 2'b10)
                            comp <= r0Data & r1Data;
                        else if (aluFuncSel == 2'b11)
                            comp <= r0Data ^ r1Data;
                    end
            end
    

endmodule



