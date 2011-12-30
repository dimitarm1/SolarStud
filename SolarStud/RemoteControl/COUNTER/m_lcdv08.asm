;***************************************************************************
;                                                                     
;	BINARY to DECIMAL CONVERSION for LCD Display for PIC 16XXX V1.02
;	================================================================
;
;	written by Peter Luethi, 18.01.1999, Dietikon, Switzerland
;	http://www.electronic-engineering.ch
;	last update: 20.08.2004
;
;	V1.02:	Changed labels such as to be able to use both, m_lcdv08.asm
;		and m_lcdv16.asm simultaneously (24.06.2004)
;	V1.01:	Replaced register with #define statement for flag
;		(16.02.2003)
;	V1.00:	Initial release (18.01.1999)
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
;	Processor:		Microchip PIC 16XXX
;	Decimal Range:		0 - 255 unsigned
;	Binary Range:		8 Bit	unsigned
; 
;
;	DESCRIPTION:
;	============
;	Developed and tested on PIC 16C84, but executeable on all PICs.
;	Evaluates from 8 bit Binary Data in LO the equivalent
;	decimal output for the LCD-Display. Preceeding zeros are
;	not displayed.
;
;	Call of implemented procedure with:
;		"LCDval_08", value in LO
;
;	LO is not altered or cleared during operation and is
;	still valid after termination of this routine.
;	During the whole routine, LO_TEMP, BCflag must NOT be used
;	by other routines !			  ========
;	TEMP1 - TEMP2 can be used by the LCD routine during conversion
;	(call of LCDw), because they will be re-defined again.
;
;
;	DECLARATIONS needed in MAIN PROGRAM :
;	=====================================
;	CONSTANT BASE = 0x0C	; Base address of user file registers
;	LO	equ	BASE+?
;	LO_TEMP	set	BASE+?
;	#define	BCflag	<reg_name>,0x00	; blank checker for preceeding zeros
;			; <reg_name> can be any register, containing also
;			; other flags
;
;
;	REQUIRED MEMORY:
;	================
;	2 registers: @ BASE+0 - BASE+1 (temporary registers)
;       2 registers: LO, LO_TEMP
;	1 flag: BCflag
;	needs itself 2 stack levels, but LCDw needs some more
;
;***************************************************************************

;***** INCLUDE FILES *****

	IFNDEF	M_LCD_ID
	  ERROR "Missing include file: m_lcd.asm or similar"
	ENDIF
	
;***** REGISTER DECLARATION *****

	IFNDEF	BASE
	  ERROR "ModuleError: Declare BASE (Base address of user file registers) in MAIN PROGRAM"
	ENDIF
	IFNDEF	LO
	  ERROR "ModuleError: Declare LO in MAIN PROGRAM"
	ENDIF
	IFNDEF	LO_TEMP
	  ERROR "ModuleError: Declare LO_TEMP in MAIN PROGRAM"
	ENDIF
	IFNDEF	BCflag
	  ERROR "ModuleError: #define BCflag FLAGreg,0x05 (Blank checker) in MAIN PROGRAM"
	ENDIF

   ; *** Universal Temporary Register ***
	TEMP1	set	BASE	; Counter
	TEMP2	set	BASE+1	; Sub-LO

;***** MACROS *****
	
LCDval_08 macro
	call LCDval08
	endm
	
;***** SUB-ROUTINES *****

LCDval08
	movfw	LO
	movwf	LO_TEMP		; LO -> LO_TEMP
	bcf	BCflag		; blank checker for preceeding zeros
	
	movlw	d'100'		; check amount of 100s
	movwf	TEMP2		; ==> Decimal Range 0 - 255 <=> 8 bit
	call	_VALcnv08	; call conversion sub-routine
	LCDw			; call LCD sub-routine with value stored in w

	movlw	d'10'		; check amount of 10s
	movwf	TEMP2
	call	_VALcnv08	; call conversion sub-routine
	LCDw			; call LCD sub-routine with value stored in w

	movlw	d'1'		; check amount of 1s
	movwf	TEMP2
	bsf	BCflag		; remove blank checker in case of zero
	call	_VALcnv08	; call conversion sub-routine
	LCDw			; call LCD sub-routine with value stored in w
	RETURN
	
_VALcnv08
	clrf	TEMP1		; counter
	movfw	TEMP2		; decrement-value	
_V08_1	subwf	LO_TEMP,0	; TEST: LO_TEMP-TEMP2 >= 0 ?
	skpc			; skip, if true
	goto	_V08_LCD	; result negativ, exit
	incf	TEMP1,1		; count
	movfw	TEMP2		; decrement-value
	subwf	LO_TEMP,1	; STORE: LO_TEMP = LO_TEMP - TEMP2
	bsf	BCflag		; invalidate flag
	goto	_V08_1		; repeat
_V08_LCD
	movlw	'0'		; writes Number to LCD
	addwf	TEMP1,0		; '0' is ascii offset, add counter
	btfss	BCflag		; check flag
	movlw	' '		; clear preceeding zeros
	; return with data in w
	RETURN
