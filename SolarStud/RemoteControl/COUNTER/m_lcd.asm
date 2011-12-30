;***************************************************************************
;                                                                     
;	LCD INTERFACE V2.06 for PIC 16XXX
;	=================================
;
;	written by Peter Luethi, 10.01.1999, Dietikon, Switzerland
;	http://www.electronic-engineering.ch
;	last update: 26.12.2004
;
;	V2.06:	Added new parameters: (26.12.2004)
;		- LCDLINENUM: (default: 0x2) # of LCD lines (affects LCDL2/3) 
;		- LCDTYPE: type of LCD/controller:
;		           - 0x0: (default) standard LCD (w/ HD44780)
;		           - 0x1: EA DIP204-4  (w/ KS0073, white chars, blue bg)
;	V2.05:	Changed LCDinit and constants (24.06.2004)
;	V2.04:	Clean-up and general improvements, added
;		parameter LCDSPEED (10.04.2004)
;	V2.03:	Improved masking of LCD data outputs,
;		reduced code size, added parameter LCDWAIT
;		(16.02.2003)
;	V2.02:	LCDinit coded as macro instead of procedure
;	V2.01:	LCDinit with "andwf" instead of "movwf"
;	V2.00:	With constant timing delays (No busy flag check)
;
;	This code and accompanying files may be distributed freely and
;	modified, provided this header with my name and this notice remain
;	intact. Ownership rights remain with me.
;	You may not sell this software without my approval.
;
;	This software comes with no guarantee or warranty except for my
;	good intentions. By using this code you agree to indemnify me from
;	any liability that might arise from its use.
;
;
;	SPECIFICATIONS:
;	===============
;	Processor:		Microchip PIC 16X84, 16F7X, 16F87X
;	Clock:			4.00 MHz XT - 10.00 MHz HS Mode	(tested)
;	Throughput:		1 - 2.5 MIPS
;	LCD Transmission Mode:	4 bit on high nibble of LCD port
;				(MSB D7-D4)
;	LCD Connections:	7 wires (4 data, 3 command),
;				LCD data on low nibble of any port,
;				LCD command on any port bits
;		  Total:	10 wires
;				(4 data, 3 command, 1 Vdd, 1 GND, 1 contrast)
;
;
;	DESCRIPTION:
;	============
;	Developed on PIC 16F84, but executeable on all PIC 16XXX.
;	Program handles all aspects of setup and display on a dot matrix LCD 
;	display. Routines are provided to allow display of characters,
;	display shifting and clearing, cursor setup, cursor positioning and
;	line change.
;
;	Program calls module m_wait.asm with implemented standard delay: 
;	"WAIT 0x01"	is equal to	1 Unit == 1.04 ms
;	The assigned standard prescaler for TMR0 is "PRESCstd = b'00000001'"
;
;	Call of implemented procedures with:
;		"LCDinit"		(macro)
;		"LCDchar 'c'"		display ascii character
;		"LCDw"			display char in working register
;		"LCDcmd xxx"		e.g. "LCDcmd LCDCLR"
;		"LCD_DDAdr xxx"		set cursor to explicit address
;					--> REFER TO LCD DOCUMENTATION
;		"LCDline x"		set cursor to the beginning of line 1/2
;
;	To display decimal-values, please include the following binary to
;	decimal conversion modules:
;		for  8 Bit: m_lcdv08.asm
;		for 16 Bit: m_lcdv16.asm
;
;
;	DEFAULT TIMING PARAMETERS:
;	==========================
;	CONSTANT LCDLINENUM = 0x02	; LCD display has two lines (e.g. 2x20)
;	CONSTANT LCDTYPE  = 0x00	; standard HD44780 LCD
;	CONSTANT LCDSPEED = 0x01	; affecting LCD_EN 'clock': high speed PIC clock
;	CONSTANT LCDWAIT  = 0x01	; for Tosc <= 5 MHz
;	CONSTANT LCDCLRWAIT = 0x08	; wait after LCDCLR until LCD is ready again
;
;	To maintain proper timing (setup time, wait time, LCD initialization),
;	adjust the parameter LCDWAIT as follows:
;	  if Tosc <= 5 MHz:  LCDWAIT = 0x01 
;	  else               LCDWAIT = floor(0.25 * clock frequency[MHz])
;	To comply with manufacturer specifications (Enable High Time >= 450 ns),
;	add a "nop" to the procedure LCDclk, if using this module with clock
;	rates higher than 9 MHz. Therefore, define in your main program:
;		CONSTANT LCDSPEED = 0x00	; clk in [0..9] MHz
;		CONSTANT LCDSPEED = 0x01	; clk in [9..20] MHz, default
;
;
;	DECLARATIONS needed in MAIN PROGRAM:
;	====================================
;	CONSTANT BASE = 0x0C	Base address of user file registers
;	LCDtris	equ	TRISB
;	LCDport	equ	PORTB
;
;	LCD port connections:	B0: not used, still available for INTB
;				B1: D4
;				B2: D5
;				B3: D6
;				B4: D7
;				B5: E
; 				B6: R/W
;				B7: RS
;
;	REQUIRED MEMORY:
;	================
;	2 registers: @ BASE+2 - BASE+3
;
;***************************************************************************
#DEFINE	M_LCD_ID dummy

;***** INCLUDE FILES *****

	IFNDEF	M_BANK_ID
	  ERROR "Missing include file: m_bank.asm"
	ENDIF
	IFNDEF	M_WAIT_ID
	  ERROR "Missing include file: m_wait.asm"
	ENDIF

;***** CONSTANT DECLARATION *****

	IFNDEF	LCDLINENUM	; use default value, if unspecified
		CONSTANT LCDLINENUM = 0x02	; by default, 2 lines
	ENDIF
	IFNDEF	LCDTYPE		; use default value, if unspecified
		CONSTANT LCDTYPE = 0x00		; standard HD44780 LCD
		;CONSTANT LCDTYPE = 0x01	; EADIP204-4 (w/ KS0073)
	ENDIF
	IFNDEF	LCDSPEED	; use default value, if unspecified
		;CONSTANT LCDSPEED = 0x00	; clk in [0..9] MHz
		CONSTANT LCDSPEED = 0x01	; clk in [9..20] MHz, default
	ENDIF
	IFNDEF	LCDWAIT		; use default value, if unspecified
		CONSTANT LCDWAIT = 0x01		; for Tosc <= 5 MHz
	ENDIF
	IFNDEF	LCDCLRWAIT	; use default value, if unspecified
		CONSTANT LCDCLRWAIT = 0x08	; wait after LCDCLR until LCD is ready again
	ENDIF

;***** HARDWARE DECLARATION *****	

	IFNDEF	LCDtris
		ERROR "Declare LCDtris in MAIN PROGRAM"
	ENDIF
	IFNDEF	LCDport
		ERROR "Declare LCDport in MAIN PROGRAM"
	ENDIF
				
	; LCD data ports D4 - D7 == 0x01 - 0x04
	#define	LCD_EN     LCDport,0x05	; Enable Output / "CLK"
	#define	LCD_RW     LCDport,0x06	; Read/Write
	#define	LCD_RS     LCDport,0x07	; Register Select

;***** REGISTER DECLARATION *****

	IFNDEF	BASE
	  ERROR "Declare BASE (Base address of user file registers) in MAIN PROGRAM"
	ENDIF

	LCDbuf	set	BASE+d'2'	; LCD data buffer
	LCDtemp	set	BASE+d'3'	; LCD temporary register

;***** LCD COMMANDS *****

  ;*** Standard LCD COMMANDS for INIT ***	( HI-NIBBLE only )
	; for 4 bit mode: send only one nibble as high-nibble [DB7:DB4]
	CONSTANT  LCDEM8  = b'0011'	; entry mode set: 8 bit mode, 2 lines
	CONSTANT  LCDEM4  = b'0010'	; entry mode set: 4 bit mode, 2 lines
	CONSTANT  LCDDZ   = b'1000'	; set Display Data Ram Address to zero

  ;*** Standard LCD COMMANDS ***		( HI- / LO-NIBBLE )
	; USE THESE COMMANDS BELOW AS FOLLOW: "LCDcmd LCDCLR"
	CONSTANT  LCDCLR  = b'00000001'	; clear display: resets address counter & cursor
	CONSTANT  LCDCH   = b'00000010'	; cursor home
	CONSTANT  LCDCR   = b'00000110'	; entry mode set: cursor moves right, display auto-shift off
	CONSTANT  LCDCL   = b'00000100'	; entry mode set: cursor moves left, display auto-shift off
	CONSTANT  LCDCONT = b'00001100'	; display control: display on, cursor off, blinking off
	CONSTANT  LCDMCL  = b'00010000'	; cursor/disp control: move cursor left
	CONSTANT  LCDMCR  = b'00010100'	; cursor/disp control: move cursor right
	CONSTANT  LCDSL   = b'00011000'	; cursor/disp control: shift display content left
	CONSTANT  LCDSR   = b'00011100'	; cursor/disp control: shift display content right
	CONSTANT  LCD2L   = b'00101000'	; function set: 4 bit mode, 2 lines, 5x7 dots
	IF (LCDLINENUM == 0x2)
	  CONSTANT  LCDL1 = b'10000000'	; DDRAM address: 0x00, selects line 1 (2xXX LCD)
	  CONSTANT  LCDL2 = b'11000000'	; DDRAM address: 0x40, selects line 2 (2xXX LCD)
	  CONSTANT  LCDL3 = b'10010100'	; (DDRAM address: 0x14, fallback)
	  CONSTANT  LCDL4 = b'11010100'	; (DDRAM address: 0x54, fallback)
	ELSE
	  CONSTANT  LCDL1 = b'10000000'	; DDRAM address: 0x00, selects line 1 (4xXX LCD)
	  CONSTANT  LCDL2 = b'10010100'	; DDRAM address: 0x14, selects line 2 (4xXX LCD)
	  CONSTANT  LCDL3 = b'11000000'	; DDRAM address: 0x40, selects line 3 (4xXX LCD)
	  CONSTANT  LCDL4 = b'11010100'	; DDRAM address: 0x54, selects line 4 (4xXX LCD)
	ENDIF
	; special configuration for EA DIP204-4
	CONSTANT  LCDEXT  = b'00001001'	; extended function set EA DIP204-4
	CONSTANT  LCD2L_A = b'00101100'	; enter ext. function set: 4 bit mode, 2 lines, 5x7 dots
	CONSTANT  LCD2L_B = b'00101000'	; exit ext. function set: 4 bit mode, 2 lines, 5x7 dots
	
;***** MACROS *****

LCDinit	macro
	BANK1
	movlw	b'0000001'	; set to output
	andwf	LCDtris,f
	BANK0
	bcf	LCD_EN		; clear LCD clock line
	bcf	LCD_RW		; set write direction
	bcf	LCD_RS		; clear command/data line
	clrLCDport		; reset LCD data lines
	WAIT	4*LCDWAIT	; >= 4 ms @ 4 MHz

	; LCD INITIALIZATION STARTS HERE
	; start in 8 bit mode
	movlw	LCDEM8		; send b'0011' on [DB7:DB4]
	call	LCDxmit		; start in 8 bit mode
	call	LCDclk		; That's while:
	WAIT	LCDWAIT 	; On POWER UP, the LCD will initialize itself,
				; but after a RESET of the microcontroller without
				; POWER OFF, the 8 bit function mode will reboot
				; the LCD to 4 bit mode safely.

	movlw	LCDDZ		; set DDRAM to zero
	call	LCDxmit
	call	LCDclk
	WAIT	LCDWAIT		; ~1 ms @ 4 MHz

	movlw	LCDEM4		; send b'0010' on [DB7:DB4]
	call	LCDxmit		; change to 4 bit mode
	call	LCDclk
	WAIT	LCDWAIT		; ~1 ms @ 4 MHz
	
	; now in 4 bit mode, sending two nibbles
	IF LCDTYPE == 0x00
	  LCDcmd LCD2L		; function set: 4 bit mode, 2 lines, 5x7 dots
	  LCDcmd LCDCONT	; display control: display on, cursor off, blinking off
	  LCDcmd LCDCLR		; clear display, address counter to zero
	  WAIT LCDCLRWAIT	; wait after LCDCLR until LCD is ready again
	ELSE
	  IF LCDTYPE == 0x01
	    ; for LCD EA DIP204-4 (white chars, blue backlight)
	    LCDcmd LCD2L_A	; switch on extended function set
	    LCDcmd LCDEXT	; 4 lines
	    LCDcmd LCD2L_B	; switch off extended function set
	    LCDcmd LCDCONT	; display control: display on, cursor off, blinking off
	    LCDcmd LCDCLR	; clear display, address counter to zero
	    WAIT LCDCLRWAIT	; wait after LCDCLR until LCD is ready again
	  ELSE
	    ERROR "Unsupported parameter"
	  ENDIF
	ENDIF
	endm

LCDchar	macro	LCDarg		; write ASCII argument to LCD
	movlw	LCDarg
	call	LCDdata
	endm
	
LCDw	macro			; write content of w to LCD
	call	LCDdata
	endm
	
LCDcmd	macro	LCDcommand	; write command to LCD
	movlw	LCDcommand
	call	LCDcomd
	endm
	
LCDline	macro	line_num
	IF (line_num == 1)
	  LCDcmd LCDL1		; first line
	ELSE
	  IF (line_num == 2)
	    LCDcmd LCDL2	; second line
	  ELSE
	    IF (line_num == 3)
	      LCDcmd LCDL3	; third line
	    ELSE
	      IF (line_num == 4)
	        LCDcmd LCDL4	; fourth line
 	      ELSE
	        ERROR "Wrong line number specified in LCDline"
	      ENDIF
	    ENDIF
	  ENDIF
	ENDIF
	endm

LCD_DDAdr macro	DDRamAddress
	Local	value = DDRamAddress | b'10000000'	; mask command
	IF (DDRamAddress > 0x67)
		ERROR "Wrong DD-RAM-Address specified in LCD_DDAdr"
	ELSE
		movlw	value
		call	LCDcomd
	ENDIF
	endm

LCD_CGAdr macro	CGRamAddress
	Local	value = CGRamAddress | b'01000000'	; mask command
	IF (CGRamAddress > b'00111111')
		ERROR "Wrong CG-RAM-Address specified in LCD_CGAdr"
	ELSE
		movlw	value
		call	LCDcomd
	ENDIF
	endm

clrLCDport macro		; clear/reset LCD data lines
	movlw	b'11100001'	; get mask
	andwf	LCDport,f	; clear data lines only
	endm

;***** SUBROUTINES *****

	; transmit only lower nibble of w
LCDxmit	movwf	LCDbuf		; store command/data nibble
	; first, clear LCD data lines
	clrLCDport
	; second, move data out to LCD data lines
	rlf	LCDbuf,w	; get data
	andlw	b'00011110'	; extract only valid part
	iorwf	LCDport,f	; put to LCD data lines
	RETURN

	; transmit command to LCD
LCDcomd	bcf	LCD_RS		; select command registers
	goto	_LCD_wr
	
	; transmit data to LCD
LCDdata	bsf	LCD_RS		; select data registers
_LCD_wr	bcf	LCD_RW		; set write direction
	movwf	LCDtemp		; store command/data to send
	; send hi-nibble
	movfw	LCDtemp		; get data
	swapf	LCDtemp,w	; swap hi- and lo-nibble, store in w
	call	LCDxmit		; transmit nibble
	call	LCDclk
	; send lo-nibble
	movfw	LCDtemp		; get data
	call	LCDxmit		; transmit nibble
	call	LCDclk
	; reset LCD controls
	clrLCDport		; reset LCD data lines
	bcf	LCD_RS		; reset command/data register
	;bcf	LCD_RW		; reset to write direction
	RETURN

	; clocks LCD data/command
LCDclk	WAIT	LCDWAIT
	bsf     LCD_EN		; set LCD enable
	; insert LCDSPEED x nops to comply with manufacturer
	; specifications for clock rates above 9 MHz
	VARIABLE CNT_V		; declare intermediate variable
	CNT_V = LCDSPEED	; assign pre-defined constant
	WHILE (CNT_V > 0x0)	; perform while loop to insert 'nops'
	  nop			; insert 'nop'
	  CNT_V -= 1		; decrement
	ENDW
	bcf     LCD_EN
	WAIT	LCDWAIT		; clocks LCD data/command
	RETURN
