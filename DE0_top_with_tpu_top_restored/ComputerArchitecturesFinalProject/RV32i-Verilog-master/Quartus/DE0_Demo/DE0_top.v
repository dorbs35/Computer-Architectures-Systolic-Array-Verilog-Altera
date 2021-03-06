// --------------------------------------------------------------------
// Copyright (c) 2009 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE0 Button Debounce
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
// Ver:| Author : Allen Wang  | Mod. Date : 2010/07/27 | Changes Made:
// --------------------------------------------------------------------

//`include "../../src/top.v"


module DE0_top
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_50,						//	50 MHz
		CLOCK_50_2,						//	50 MHz
		////////////////////	Push Button		////////////////////
		ORG_BUTTON,						//	Pushbutton[2:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[9:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0_D,							//	Seven Segment Digit 0
		HEX0_DP,						//	Seven Segment Digit DP 0
		HEX1_D,							//	Seven Segment Digit 1
		HEX1_DP,						//	Seven Segment Digit DP 1
		HEX2_D,							//	Seven Segment Digit 2
		HEX2_DP,						//	Seven Segment Digit DP 2
		HEX3_D,							//	Seven Segment Digit 3
		HEX3_DP,						//	Seven Segment Digit DP 3
		HEX4_D,							//	Seven Segment Digit 4
		HEX4_DP,						//	Seven Segment Digit DP 4
		HEX5_D,							//	Seven Segment Digit 5
		HEX5_DP,						//	Seven Segment Digit DP 5
		////////////////////////	LED		////////////////////////
		LEDG							//	LED Red[9:0]
		////////////////////////	UART	////////////////////////
		//UART_TXD,						//	UART Transmitter
		//UART_RXD,						//	UART Receiver
		//UART_CTS,						//	UART Clear To Send
		//UART_RTS,						//	UART Request To Send
		/////////////////////	SDRAM Interface		////////////////
		//DRAM_DQ,						//	SDRAM Data bus 16 Bits
		//DRAM_ADDR,						//	SDRAM Address bus 13 Bits
		//DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		//DRAM_UDQM,						//	SDRAM High-byte Data Mask
		//DRAM_WE_N,						//	SDRAM Write Enable
		//DRAM_CAS_N,						//	SDRAM Column Address Strobe
		//DRAM_RAS_N,						//	SDRAM Row Address Strobe
		//DRAM_CS_N,						//	SDRAM Chip Select
		//DRAM_BA_0,						//	SDRAM Bank Address 0
		//DRAM_BA_1,						//	SDRAM Bank Address 1
		//DRAM_CLK,						//	SDRAM Clock
		//DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		//FL_DQ,							//	FLASH Data bus 15 Bits
		//FL_DQ15_AM1,					//	FLASH Data bus Bit 15 or Address A-1
		//FL_ADDR,						//	FLASH Address bus 22 Bits
		//FL_WE_N,						//	FLASH Write Enable
		//FL_RST_N,						//	FLASH Reset
		//FL_OE_N,						//	FLASH Output Enable
		//FL_CE_N,						//	FLASH Chip Enable
		//FL_WP_N,						//	FLASH Hardware Write Protect
		//FL_BYTE_N,						//	FLASH Selects 8/16-bit mode
		//FL_RY,							//	FLASH Ready/Busy
		////////////////////	LCD Module 16X2		////////////////
		//LCD_BLON,						//	LCD Back Light ON/OFF
		//LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		//LCD_EN,							//	LCD Enable
		//LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		//LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		//SD_DAT0,						//	SD Card Data 0
		//SD_DAT3,						//	SD Card Data 3
		//SD_CMD,							//	SD Card Command Signal
		//SD_CLK,							//	SD Card Clock
		//SD_WP_N,						//	SD Card Write Protect
		////////////////////	PS2		////////////////////////////
		//PS2_KBDAT,						//	PS2 Keyboard Data
		//PS2_KBCLK,						//	PS2 Keyboard Clock
		//PS2_MSDAT,						//	PS2 Mouse Data
		//PS2_MSCLK,						//	PS2 Mouse Clock
		////////////////////	VGA		////////////////////////////
		//VGA_HS,							//	VGA H_SYNC
		//VGA_VS,							//	VGA V_SYNC
		//VGA_R,   						//	VGA Red[3:0]
		//VGA_G,	 						//	VGA Green[3:0]
		//VGA_B,  						//	VGA Blue[3:0]
		////////////////////	GPIO	////////////////////////////
		//GPIO0_CLKIN,					//	GPIO Connection 0 Clock In Bus
		//GPIO0_CLKOUT,					//	GPIO Connection 0 Clock Out Bus
		//GPIO0_D,						//	GPIO Connection 0 Data Bus
		//GPIO1_CLKIN,					//	GPIO Connection 1 Clock In Bus
		//GPIO1_CLKOUT,					//	GPIO Connection 1 Clock Out Bus
		//GPIO1_D							//	GPIO Connection 1 Data Bus
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_50;				//	50 MHz
input			CLOCK_50_2;				//	50 MHz
////////////////////////	Push Button		////////////////////////
input	[3:0]	ORG_BUTTON;				//	Pushbutton[2:0]
////////////////////////	DPDT Switch		////////////////////////
input	[9:0]	SW;						//	Toggle Switch[9:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0_D;					//	Seven Segment Digit 0
output			HEX0_DP;				//	Seven Segment Digit DP 0
output	[6:0]	HEX1_D;					//	Seven Segment Digit 1
output			HEX1_DP;				//	Seven Segment Digit DP 1
output	[6:0]	HEX2_D;					//	Seven Segment Digit 2
output			HEX2_DP;				//	Seven Segment Digit DP 2
output	[6:0]	HEX3_D;					//	Seven Segment Digit 3
output			HEX3_DP;				//	Seven Segment Digit DP 3
output	[6:0]	HEX4_D;					//	Seven Segment Digit 4
output			HEX4_DP;				//	Seven Segment Digit DP 4
output	[6:0]	HEX5_D;					//	Seven Segment Digit 5
output			HEX5_DP;				//	Seven Segment Digit DP 5

////////////////////////////	LED		////////////////////////////
 output reg	[9:0]	LEDG;					//	LED Red[9:0]
////////////////////////////	UART	////////////////////////////
//output			UART_TXD;				//	UART Transmitter
//input			UART_RXD;				//	UART Receiver
//output			UART_CTS;				//	UART Clear To Send
//input			UART_RTS;				//	UART Request To Send
///////////////////////		SDRAM Interface	////////////////////////
//inout	[15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
//output	[12:0]	DRAM_ADDR;				//	SDRAM Address bus 13 Bits
//output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask
//output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
//output			DRAM_WE_N;				//	SDRAM Write Enable
//output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
//output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
//output			DRAM_CS_N;				//	SDRAM Chip Select
//output			DRAM_BA_0;				//	SDRAM Bank Address 0
//output			DRAM_BA_1;				//	SDRAM Bank Address 1
//output			DRAM_CLK;				//	SDRAM Clock
//output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
//inout	[14:0]	FL_DQ;					//	FLASH Data bus 15 Bits
//inout			FL_DQ15_AM1;			//	FLASH Data bus Bit 15 or Address A-1
//output	[21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
//output			FL_WE_N;				//	FLASH Write Enable
//output			FL_RST_N;				//	FLASH Reset
//output			FL_OE_N;				//	FLASH Output Enable
//output			FL_CE_N;				//	FLASH Chip Enable
//output			FL_WP_N;				//	FLASH Hardware Write Protect
//output			FL_BYTE_N;				//	FLASH Selects 8/16-bit mode
//input			FL_RY;					//	FLASH Ready/Busy
////////////////////	LCD Module 16X2	////////////////////////////
//inout	[7:0]	LCD_DATA;				//	LCD Data bus 8 bits
//output			LCD_BLON;				//	LCD Back Light ON/OFF
//output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
//output			LCD_EN;					//	LCD Enable
//output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
//inout			SD_DAT0;				//	SD Card Data 0
//inout			SD_DAT3;				//	SD Card Data 3
//inout			SD_CMD;					//	SD Card Command Signal
//output			SD_CLK;					//	SD Card Clock
//input			SD_WP_N;				//	SD Card Write Protect
////////////////////////	PS2		////////////////////////////////
//inout		 	PS2_KBDAT;				//	PS2 Keyboard Data
//inout			PS2_KBCLK;				//	PS2 Keyboard Clock
//inout		 	PS2_MSDAT;				//	PS2 Mouse Data
//inout			PS2_MSCLK;				//	PS2 Mouse Clock
////////////////////////	VGA			////////////////////////////
//output			VGA_HS;					//	VGA H_SYNC
//output			VGA_VS;					//	VGA V_SYNC
//output	[3:0]	VGA_R;   				//	VGA Red[3:0]
//output	[3:0]	VGA_G;	 				//	VGA Green[3:0]
//output	[3:0]	VGA_B;   				//	VGA Blue[3:0]
////////////////////////	GPIO	////////////////////////////////
//input	[1:0]	GPIO0_CLKIN;			//	GPIO Connection 0 Clock In Bus
//output	[1:0]	GPIO0_CLKOUT;			//	GPIO Connection 0 Clock Out Bus
//inout	[31:0]	GPIO0_D;				//	GPIO Connection 0 Data Bus
//input	[1:0]	GPIO1_CLKIN;			//	GPIO Connection 1 Clock In Bus
//output	[1:0]	GPIO1_CLKOUT;			//	GPIO Connection 1 Clock Out Bus
//inout	[31:0]	GPIO1_D;				//	GPIO Connection 1 Data Bus




//==================================================================
//  REG/WIRE declarations
//==================================================================
wire	[3:0]	ORG_BUTTON;         		// Button 

wire            reset_n;        		// Reset
wire            BUTTON[0:2];		// Button after debounce

wire    		counter_1;      		// Counter for Button[1]
wire    		counter_2;      		// Counter for Button[2]
wire    [3:0]   iDIG_2;
wire    [3:0]   iDIG_3;
wire    [3:0]   iDIG_4;
wire    [3:0]   iDIG_5;

wire    [3:0] 	iDIG_0;        			// 7SEG 0 
wire    [3:0] 	iDIG_1;         		// 7SEG 1
reg       		out_BUTTON_1;   		// Button1 Register output
reg       		out_BUTTON_2;   		// Button2 Register output

reg            virtual_clk;       // Virtual clock to slow the processor
wire           clock_to_core;

reg [21:0] count_reg = 0;
reg out_10hz = 0;

// declarations - shachar kaduri and dor bar shai

reg [31:0]rowA0,rowA1,rowA2,rowA3;
reg [31:0]colB0,colB1,colB2,colB3;

reg [3:0]counter;

wire [31:0]tpu_val_write_rowC0,tpu_val_write_rowC1,tpu_val_write_rowC2,tpu_val_write_rowC3;
wire done_bit;
reg [3:0]sysgo;
reg [3:0]sysdone;
reg go_bit;

initial begin
	rowA0 <= 32'h02010101;
	rowA1 <= 32'h01010101;
	rowA2 <= 32'h01010101;
	rowA3 <= 32'h01010101;
	colB0 <= 32'h01010101;
	colB1 <= 32'h01010101;
	colB2 <= 32'h01010101;
	colB3 <= 32'h01010101;
	sysdone <= 4'b1111;
	sysgo <= 4'b0000;
	go_bit <= 1'b0;
	counter <= 0;
end
// end our declarations

//==================================================================
//  Structural coding
//==================================================================

PLL PLL_instance(
	.inclk0(CLOCK_50),
	.c0(PLL_1MHzclock));


// This is BUTTON[0] Debounce Circuit //
button_debouncer	button_debouncer_inst0(
	.clk     (PLL_1MHzclock),
	.rst_n   (1'b1),
	.data_in (ORG_BUTTON[0]),
	.data_out(BUTTON[0])			
	);
	
// This is BUTTON[1] Debounce Circuit //
button_debouncer	button_debouncer_inst1(
	.clk     (PLL_1MHzclock),
	.rst_n   (1'b1),
	.data_in (ORG_BUTTON[1]),
	.data_out(BUTTON[1])			
	);
	
// This is BUTTON[2] Debounce Circuit //
button_debouncer	button_debouncer_inst2(
	.clk     (PLL_1MHzclock),
	.rst_n   (1'b1),
	.data_in (ORG_BUTTON[2]),
	.data_out(BUTTON[2])			
	);

// This is SEG0 Display//
SEG7_LUT	SEG0(
				 .oSEG   (HEX0_D),
				 .oSEG_DP(),
				 .iDIG   (iDIG_0)
				 );
				 
// This is SEG1 Display//
SEG7_LUT	SEG1(
				 .oSEG   (HEX1_D),
				 .oSEG_DP(),
				 .iDIG   (iDIG_1)
				 );
				 
// This is SEG2 Display//
SEG7_LUT	SEG2(
				 .oSEG   (HEX2_D),
				 .oSEG_DP(),
				 .iDIG   (iDIG_2)
				 );
				 
// This is SEG3 Display//				 
SEG7_LUT	SEG3(
				 .oSEG   (HEX3_D),
				 .oSEG_DP(),
				 .iDIG   (iDIG_3)
				  );	
				  
// This is SEG3 Display//				 
SEG7_LUT	SEG4(
				 .oSEG   (HEX4_D),
				 .oSEG_DP(),
				 .iDIG   (iDIG_4)
				  );
				  
				  // This is SEG3 Display//				 
SEG7_LUT	SEG5(
				 .oSEG   (HEX5_D),
				 .oSEG_DP(),
				 .iDIG   (iDIG_5)
				  );

//top top_inst(
//	.clk (virtual_clk),
//	.rst_n (BUTTON[0])
//);

//==================================================================
// tpu_top
//==================================================================
	tpu_top tpu_top_inst0(
	 .clk (clock_to_core),
	 .rst_n (reset_n),    
	 .go_bit (go_bit),
	 .done_bit (done_bit),
	 .rowA0 (rowA0),
	 .rowA1 (rowA1),
	 .rowA2 (rowA2),
	 .rowA3 (rowA3),
	 .colB0 (colB0),
	 .colB1 (colB1),
	 .colB2 (colB2),
	 .colB3 (colB3),
	 .rowC0 (tpu_val_write_rowC0),
	 .rowC1 (tpu_val_write_rowC1),
	 .rowC2 (tpu_val_write_rowC2),
	 .rowC3 (tpu_val_write_rowC3)
	 );
//==================================================================

`ifdef CUSTOM_DEFINE
		  parameter ADDR_WIDTH = `MEM_ADDR_WIDTH;
        parameter DATA_WIDTH = `REG_DATA_WIDTH;
        parameter TRANSFER_WIDTH = `MEM_TRANSFER_WIDTH;
`else
		parameter ADDR_WIDTH = 10;
        parameter DATA_WIDTH = 32;
        parameter TRANSFER_WIDTH = 4;
`endif

   

    wire we_mem_data;
    wire [ADDR_WIDTH-1 : 0] addr_mem_data;
    wire [DATA_WIDTH-1 : 0] val_mem_data_write;
    wire [DATA_WIDTH-1 : 0] val_mem_data_read;

    wire [ADDR_WIDTH-1 : 0] addr_mem_prog;
    wire [DATA_WIDTH-1 : 0] val_mem_prog;

    wire  [TRANSFER_WIDTH-1:0] write_transfer;
	 
	 wire PLL_1MHzclock;


core core_de0(
        .clk (clock_to_core),
        .rst_n (reset_n),
        .we_mem_data_o (we_mem_data),
        .addr_mem_data_o (addr_mem_data),
        .val_mem_data_read_i (val_mem_data_read),
        .val_mem_data_write_o (val_mem_data_write),
        .addr_mem_prog_o (addr_mem_prog),
        .val_mem_prog_i (val_mem_prog),
        .write_transfer_mem_data_o (write_transfer)
    );
//set LOAD_MEMS to true to load mems

//`define MEM

`ifdef MEM

ram mem_data_de0 (
        .clock		(clock_to_core)	,
        .wren			(we_mem_data)	,  // Write Enable
        .address		(addr_mem_data[ADDR_WIDTH-1 : 2])	,  // Address
        .data	(val_mem_data_write),  //  Data in
        .byteena (write_transfer), // write Byte mask
		  .q   (val_mem_data_read)  //data out 
    );

`else

dataMem mem_data_de0 (
        .rst_n		(reset_n)			,  // Reset Neg
        .clk		(clock_to_core)	,
        .we			(we_mem_data)	,  // Write Enable
        .addr		(addr_mem_data)	,  // Address
        .data_in	(val_mem_data_write),  //  Data in
        .data_out   (val_mem_data_read),  //data out
        .write_transfer_i (write_transfer) // write Byte mask
    );
`endif

	

`ifdef MEM

prog mem_prog_de0 (
	.address(addr_mem_prog[ADDR_WIDTH-1 : 2]),
	.clock (clock_to_core),
	.q (val_mem_prog)
	);
	 
`else
progMem mem_prog_de0 (
        .rst_n (reset_n)		,  // Reset Neg
        .clk (clock_to_core),             // Clk
        .addr (addr_mem_prog)		,  // Address
        .data_out (val_mem_prog)	   // Output Data
    );

`endif

//assign {iDig3, iDig2, iDig1, iDig0} = val_mem_prog[31:16];
//assign iDIG_0    = addr_mem_prog[3:0];
//assign iDIG_1    = addr_mem_prog[7:4];

//assign iDIG_0    = val_mem_prog[19:16];
//assign iDIG_1    = val_mem_prog[23:20];
//assign iDIG_2    = val_mem_prog[27:24]; 
//assign iDIG_3    = val_mem_prog[31:28];

//----------------------------------------------------------------------------
//	Shachar Dor's edits to Seven Segment
//----------------------------------------------------------------------------
assign iDIG_0    = val_mem_data_write[27:24];
assign iDIG_1    = val_mem_data_write[31:28];
assign iDIG_2    = counter[3:0]; 
assign iDIG_3    = sysdone;
assign iDIG_4    = go_bit;
//----------------------------------------------------------------------------
// end Shachar Dor's edits
//----------------------------------------------------------------------------

assign reset_n   = BUTTON[0];	 
//assign counter_1 = ((BUTTON[1] == 0) && (out_BUTTON_1 == 1)) ?1:0;
//assign counter_2 = ((BUTTON[2] == 0) && (out_BUTTON_2 == 1)) ?1:0;
assign iDIG_5 = clock_to_core ? 4'b1 : 4'b0;
//assign HEX1_DP = (addr_mem_data == 9'h014 && we_mem_data)? 1'b0:1'b1;
//assign HEX2_DP = !we_mem_data;
//assign HEX3_DP = !write_transfer[0];
assign clock_to_core = SW[0] ?  (SW[1])? out_10hz:PLL_1MHzclock :virtual_clk;  // SW[0] ? CLOCK_50:PLL_1MHzclock;  //
//assign LEDG[0] = ((addr_mem_data == 9'h014))? 1:0;

//====================================================================
// After debounce output with register
//====================================================================
always @ (posedge PLL_1MHzclock )
	begin
		out_BUTTON_1 <= BUTTON[1];
		out_BUTTON_2 <= BUTTON[2];
	end

	
always @ (negedge out_BUTTON_2 )
	begin
		if (virtual_clk) virtual_clk = 1'b0;
		else virtual_clk = 1'b1;
	end
//====================================================================
// Display process
//====================================================================
// GPIO
always @(posedge clock_to_core or negedge reset_n)
  begin
  if (!reset_n) begin 
		LEDG <= 10'h3000;
  //else LEDG <= we_mem_data ?  val_mem_data_write[31:22] : 10'h000;
		rowA0 <= 32'h02010101;
		rowA1 <= 32'h01010101;
		rowA2 <= 32'h01010101;
		rowA3 <= 32'h01010101;
		colB0 <= 32'h01010101;
		colB1 <= 32'h01010101;
		colB2 <= 32'h01010101;
		colB3 <= 32'h01010101;		
		sysdone <= 4'b1111;
		sysgo <= 4'b0000;
		go_bit <= 1'b0;
		counter <= 0;		
  end
  else begin
		if( addr_mem_data == 8'h2C && we_mem_data) begin
			go_bit <= 1'b1;
		end
		if(addr_mem_data == 7'hC && we_mem_data) begin // C hex = 12 dec = 0000001100
			rowA0[31:24] <= val_mem_data_write[31:24];
			rowA0[23:16] <= val_mem_data_write[23:16];
			rowA0[15:8] <= val_mem_data_write[15:8];
			rowA0[7:0] <= val_mem_data_write[7:0];
		end
	   if(addr_mem_data == 7'h1C && we_mem_data) begin // 10 hex = 16 dec = 0000010000
			colB0[31:24] <= val_mem_data_write[31:24];
			colB0[23:16] <= val_mem_data_write[23:16];
			colB0[15:8] <= val_mem_data_write[15:8];
			colB0[7:0] <= val_mem_data_write[7:0];				
		end
	   if(addr_mem_data == 7'h10 && we_mem_data) begin // C hex = 12 dec = 0000001100
			rowA1[31:24] <= val_mem_data_write[31:24];
			rowA1[23:16] <= val_mem_data_write[23:16];
			rowA1[15:8] <= val_mem_data_write[15:8];
			rowA1[7:0] <= val_mem_data_write[7:0];
		end
		if(addr_mem_data == 7'h20 && we_mem_data) begin // 10 hex = 16 dec = 0000010000
			colB1[31:24] <= val_mem_data_write[31:24];
			colB1[23:16] <= val_mem_data_write[23:16];
			colB1[15:8] <= val_mem_data_write[15:8];
			colB1[7:0] <= val_mem_data_write[7:0];				
		end
	   if(addr_mem_data == 7'h14 && we_mem_data) begin // C hex = 12 dec = 0000001100
			rowA2[31:24] <= val_mem_data_write[31:24];
			rowA2[23:16] <= val_mem_data_write[23:16];
			rowA2[15:8] <= val_mem_data_write[15:8];
			rowA2[7:0] <= val_mem_data_write[7:0];
		end
		if(addr_mem_data == 7'h24 && we_mem_data) begin // 10 hex = 16 dec = 0000010000
			colB2[31:24] <= val_mem_data_write[31:24];
			colB2[23:16] <= val_mem_data_write[23:16];
			colB2[15:8] <= val_mem_data_write[15:8];
			colB2[7:0] <= val_mem_data_write[7:0];				
		end
	   if(addr_mem_data == 7'h18 && we_mem_data) begin // C hex = 12 dec = 0000001100
			rowA3[31:24] <= val_mem_data_write[31:24];
			rowA3[23:16] <= val_mem_data_write[23:16];
			rowA3[15:8] <= val_mem_data_write[15:8];
			rowA3[7:0] <= val_mem_data_write[7:0];
		end
		if(addr_mem_data == 7'h28	 && we_mem_data) begin // 10 hex = 16 dec = 0000010000
			colB3[31:24] <= val_mem_data_write[31:24];
			colB3[23:16] <= val_mem_data_write[23:16];
			colB3[15:8] <= val_mem_data_write[15:8];
			colB3[7:0] <= val_mem_data_write[7:0];				
		end
//		go_bit <= 1'b1;
		if(done_bit) begin			
			sysdone <= 4'b1101; //show D
		end
		if (done_bit || sysdone == 4'b1101) begin
			if(counter == 4'b0000) LEDG[7:0] <= tpu_val_write_rowC0[31:24];
			if(counter == 4'b0001) LEDG[7:0] <= tpu_val_write_rowC0[23:16];
			if(counter == 4'b0010) LEDG[7:0] <= tpu_val_write_rowC0[15:8];
			if(counter == 4'b0011) LEDG[7:0] <= tpu_val_write_rowC0[7:0];
			if(counter == 4'b0100) LEDG[7:0] <= tpu_val_write_rowC1[31:24];
			if(counter == 4'b0101) LEDG[7:0] <= tpu_val_write_rowC1[23:16];
			if(counter == 4'b0110) LEDG[7:0] <= tpu_val_write_rowC1[15:8];
			if(counter == 4'b0111) LEDG[7:0] <= tpu_val_write_rowC1[7:0];
			if(counter == 4'b1000) LEDG[7:0] <= tpu_val_write_rowC2[31:24];
			if(counter == 4'b1001) LEDG[7:0] <= tpu_val_write_rowC2[23:16];
			if(counter == 4'b1010) LEDG[7:0] <= tpu_val_write_rowC2[15:8];
			if(counter == 4'b1011) LEDG[7:0] <= tpu_val_write_rowC2[7:0];
			if(counter == 4'b1100) LEDG[7:0] <= tpu_val_write_rowC3[31:24];
			if(counter == 4'b1101) LEDG[7:0] <= tpu_val_write_rowC3[23:16];
			if(counter == 4'b1110) LEDG[7:0] <= tpu_val_write_rowC3[15:8];
			if(counter == 4'b1111) LEDG[7:0] <= tpu_val_write_rowC3[7:0];
			counter <= counter + 1;	
		end
  end
end

// generate 100 Hz from 50 MHz


always @(posedge PLL_1MHzclock or negedge reset_n) begin
    if (!reset_n) begin
        count_reg <= 0;
        out_10hz <= 0;
    end else begin
        if (count_reg < 599999) begin
            count_reg <= count_reg + 1;
        end else begin
            count_reg <= 0;
            out_10hz <= ~out_10hz;
        end
    end
end

endmodule