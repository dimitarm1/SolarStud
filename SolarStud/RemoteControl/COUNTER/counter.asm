;***************************************************************************
;                                                                     
;	LCDv16 Test Routine for PIC 16XXX V1.02
;	=======================================
;
;	written by Peter Luethi, 26.03.1999, Dietikon, Switzerland
;	http://www.electronic-engineering.ch
;	last update: 05.01.2005
;
;	V1.02:	Added binary representation of counter value
;		(05.01.2005)
;
;	V1.01:	Clean up and adaptation to latest module versions
;		(31.12.2000)
;
;	V1.00:	Initial release
;		(26.03.1999)
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
;	Processor:			Microchip PIC 16C84, PIC 16F84
;	Clock:				4.00 MHz XT
;	Throughput:			1 MIPS
;	Code Size of entire Program:	approx. 203 instruction words
;	Required Hardware:		HD44780 compatible dot matrix LCD
;					(2x16, 2x20 or 2x40 characters)
;
;
;	DESCRIPTION:
;	============
;	Developed on PIC 16C84, but executeable on all PIC 16XXX.
;	Demonstrates LCD initialization and the use of some LCD commands, as
;	well as 16 bit binary to decimal conversion module file m_lcdv16.asm,
;	and 16 bit binary LCD output module m_lcdb16.asm (for debugging).
;
;***************************************************************************

;***** COMPILATION MESSAGES & WARNINGS *****

	ERRORLEVEL -207 	; Found label after column 1.
	ERRORLEVEL -302 	; Register in operand not in bank 0.

;***** PROCESSOR DECLARATION & CONFIGURATION *****

	PROCESSOR 16F84
	#include "p16f84.inc"
	
	; embed Configuration Data within .asm File.
	__CONFIG   _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC

;***** MEMORY STRUCTURE *****

	ORG     0x00			; processor reset vector
  	goto    MAIN

	ORG     0x04			; interrupt vector location
	goto	MAIN			; no ISR

;***** PORT DECLARATION *****

	LCDtris	equ	TRISB
	LCDport	equ	PORTB

;***** CONSTANT DECLARATION *****

	CONSTANT BASE = 0x0C		; base address of user file registers	

;***** REGISTER DECLARATION *****

	FLAGreg	equ	BASE+d'4'
	LO	equ	BASE+d'5'
	HI	equ	BASE+d'6'
	LO_TEMP	set	BASE+d'7'
	HI_TEMP	set	BASE+d'8'
	b16_cnt equ	BASE+d'9'	; counter
	#define	BCflag	FLAGreg,0x00	; blank checker for preceeding zeros

;***** INCLUDE FILES *****

	#include "..\..\m_bank.asm"
	#include "..\..\m_wait.asm"
	#include "..\..\m_lcd.asm"
	#include "..\..\m_lcdv16.asm"	; 16 bit binary to decimal conversion
	#include "..\..\m_lcdb16.asm"	; 16 bit binary debug output on LCD

;***** MACROS *****


;***** SUBROUTINES *****


;************** MAIN **************

MAIN
	LCDinit			; LCD Initialization
	clrf	HI
	clrf	LO

	LCDchar	'C'
	LCDchar	'n'
	LCDchar	't'
	LCDchar	'-'	
	LCDchar	'V'
	LCDchar	'a'
	LCDchar	'l'
	LCDchar	'u'
	LCDchar	'e'
	LCDchar	':'

m_loop	LCD_DDAdr 0x0B		; goto specific LCD position on line 1
	LCDval_16		; decimal representation

	LCD_DDAdr 0x40		; goto specific LCD position on line 2
	LCDbin_16		; decimal representation

	movlw	0x01		; increment LO with addwf
	addwf	LO,f		; => affects carry bit
	addcf	HI,f		; add carry bit to HI
				; no jumps necessary !
	WAIT	0x40
	goto	m_loop

	END
