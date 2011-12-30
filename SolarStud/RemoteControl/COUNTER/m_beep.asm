;***************************************************************************
;                                                                     
;	Beep Routine for PIC 16XXX  V1.00
;	=================================
;
;	written by Peter Luethi, 18.01.1999, Dietikon, Switzerland
;	http://www.electronic-engineering.ch
;	last update: 16.02.2003
;
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
;	Clock:			4.00 MHz XT
;	Throughput:		1 MIPS
;	Required Hardware:	Piezo beeper with decoupling capacitor
;
;
;	DESCRIPTION:
;	============
;	Developed on PIC 16C84, but executeable on all PIC 16X84, 16C7X, ...
;
;	Call of implemented procedures with:
;		"BEEPinit"		initialization to set output port
;		"BEEP xxx yyy"		normal usage
;		"BEEPX xxx yyy zzz"	extended usage
;			xxx is frequency-related 
;			yyy is duration according to PRESCbeeb, TMR0
;			zzz is user-defined TMR0 prescaler setting
;
;	i.e. 3-Tone-Melody:	BEEP	0xFF, 0x02
;				BEEP	0x90, 0x05
;				BEEP	0xC0, 0x03
;
;
;	DECLARATIONS needed in MAIN PROGRAM:
;	====================================
;	CONSTANT BASE = 0x0C		Base address of user file registers
;	#define		BEEPport	PORTA,0x00
;	#define		BEEPtris	TRISA,0x00
;                                                                     
;
;	REQUIRED MEMORY:
;	================
;	3 registers: @ BASE+0 - BASE+2
;
;***************************************************************************
#DEFINE	M_BEEP_ID dummy

;***** INCLUDE FILES *****

	IFNDEF	M_BANK_ID
	  ERROR "Missing include file: m_bank.asm"
	ENDIF
	
;***** HARDWARE DECLARATION *****	

	IFNDEF	BEEPport
		ERROR "Define BEEPport in MAIN PROGRAM"
	ENDIF
	IFNDEF	BEEPtris
		ERROR "Define BEEPtris in MAIN PROGRAM"
	ENDIF
	
;***** PARAMETERIZATION *****

	IFNDEF	PRESCbeep
		#define PRESCbeep b'00000111'	; 65,3  ms per Cycle
	ENDIF

;***** REGISTER DECLARATION *****

	TEMP1	set	BASE	; universal temporary register
	TEMP2	set	BASE+1
	TEMP3	set	BASE+2
	
;***** MACROS *****

BEEP	macro	freq, duration
	movlw	freq		; assign frequency
	movwf	TEMP1
	movlw	duration	; assign duration
	call	BEEPsub
	endm

BEEPX	macro	freq, duration, prescaler
	movlw	freq		; assign frequency
	movwf	TEMP1
	movlw	duration	; assign duration
	movwf	TEMP2
	clrf	TMR0
	BANK1
	movlw	prescaler	; assign prescaler for TMR0
	call	BEEPsub2
	endm

BEEPinit macro
	bcf	BEEPport
	BANK1
	bcf	BEEPtris
	BANK0
	endm

;***** SUBROUTINES *****

BEEPsub	movwf	TEMP2		; assign duration
	clrf	TMR0
	BANK1
	movlw	PRESCbeep	; assign prescaler for TMR0
BEEPsub2 movwf	OPTION_REG	; assign W to OPTION
	BANK0
BEEPa	bcf	INTCON,T0IF	; clear TMR0 Overflow Flag
BEEPb	bsf	BEEPport
	call	B_Wait
	bcf	BEEPport
	call	B_Wait
	btfss	INTCON,T0IF	; check TMR0 Overflow Flag, skip if set
	goto	BEEPb
	decfsz	TEMP2,1		; repeat subroutine
	goto	BEEPa
	RETURN
	
B_Wait	movfw	TEMP1
	movwf	TEMP3
B_Waita	decfsz	TEMP3,1
	goto	B_Waita
	RETURN

