 title  "8WireLCD - Write 'Hello' to an LCD using 8 Wires"
;
;  This Code Sends the data to the LCD in 8 Bit mode and
;   writes the string: "Hello".
;

;
;  Hardware Notes:
;   Reset is tied directly to Vcc and PWRT is Enabled.
;   The PIC is a 16C84 Running at 4 MHz.
;   PortA.0 is the Enable Bit
;   PortA.1 is the Register Select Bit
;
;

;
;******************************************************************************
;
;
; Program =SolarControl 6 - Remote control for solarium with LCD-interfacing display via 3 wires + LED static display
; with serial loading of the data
; Revision Date:  apr 2008
; for 4Mhz Quarz 
; 
;
;******************************************************************************
;
 LIST P=16F88
 INCLUDE <p16f88.inc>
; P16f88.INC Standard Header File, Version 1.00 Microchip Technology, Inc.

;Program Configuration Register 1
               __CONFIG    _CONFIG1, _CP_OFF &  _DEBUG_OFF & _WRT_PROTECT_OFF & _CPD_OFF & _LVP_OFF & _BODEN_OFF & _MCLR_OFF & _PWRTE_ON & _WDT_OFF & _XT_OSC

;Program Configuration Register 2
               __CONFIG    _CONFIG2, _IESO_OFF & _FCMEN_OFF

FALSE EQU 0
TRUE EQU 1
;  Register Usage
                    ;  Start Registers at End of the Values
Dlay EQU 0x73                            ;  8 Bit Delay Variable
Temp EQU 0X74;  Temporary Value Used When Sending Out Data
NOTemp EQU 0X75;  Temporary Value to "NybbleOutput"
 
TEMP3 EQU 0x70
TEMP4 EQU 0x71
TEMP5 EQU 0x72
ADDRH EQU 0X73
ADDRL EQU 0X74
DATAL EQU 0X75
DATAH EQU 0X76
MCOUNTER EQU 0X77
RCOUNTER EQU 0x30
BUTTON_PRESSED EQU 0x31
SCOUNTER EQU 0x32
SEND_BUFFER EQU 0x33
DIGIT0 EQU 0x40
;DIGIT12 EQU 0x4b - But addressed indirectly
;  Define Inforation
#DEFINE Data PORTA,1    ; Pin18
#DEFINE Clock PORTA,0   ; Pin17
#DEFINE R_S  PORTA,1    ; Same as Data
#DEFINE Enable_LCD PORTA,2 ; Pin1
#DEFINE Enable_LED PORTA,3 ; Pin2
#DEFINE RESET_LED PORTA,4 ; Pin3
#DEFINE Button_Read PORTA,5 ; Pin4

#DEFINE DigitEnable1 PORTB,0 ; Pin6
#DEFINE DigitEnable2 PORTB,3 ; Pin9
#DEFINE DigitEnable3 PORTB,6 ; Pin12
#DEFINE DigitEnable4 PORTB,1 ; Pin7
#DEFINE DigitEnable5 PORTB,4 ; Pin10
#DEFINE DigitEnable6 PORTB,7 ; Pin13


;  Macros
gotoxy	macro	x, y
	movlw	(y << 6) | (x & B'00111111')
	call	lcd_gotoxy
	endm
ClockStrobe MACRO;  Strobe the Data Bit
	bsf Clock
	nop
	bcf Clock
	nop
	ENDM
EStrobe MACRO;  Strobe the "E" Bit
	bsf Enable_LCD 
	call Dlay160
	bcf Enable_LCD 
	ENDM
EStrobe2 MACRO;  Strobe the "E" Bit
	bsf Enable_LCD  
 	nop
	bcf Enable_LCD  
	ENDM
 PAGE

;  Demo Code, Loop Forever 
; Reset address. Determine type of RESET
;
    org 0; RESET vector location
    GOTO   RESET
    org 4; INTERRUPT location
    GOTO PER_INT_V

    org 10; RESET vector location
RESET

;        BSF STATUS, RP0 ; Bank 1
;        BTFSC STATUS, NOT_PD ; Power-up reset?
        GOTO START0 ; YES
;        GOTO OTHER_RESET ; NO, a WDT or MCLR reset
;
; This is the Periperal Interrupt routine. Need to determine the type
; of interrupt that occurred. The following interrupts are enabled:
; 1. PORTB Change (RBIF)
; 2. TMR1 Overflow Interrupt (T1IF)

PER_INT_V
   RETI



START0

 clrf   PORTB

	BSF STATUS, RP1 ; Select Bank 2
	BCF STATUS,RP0


	BSF STATUS, RP0 ; Select Bank 1
	BCF STATUS,RP1
	MOVLW H'00'
	MOVWF ANSEL ; as digital
	MOVLW B'11100000'
	MOVWF TRISA     ;PORT RA5-RA7 ARE INPUTS
	MOVLW B'00000000'      ;FF-input
	MOVWF TRISB     ;PORT RB0-RB5 ARE outputs
	MOVLW B'00000100'       ;SET TMR0 PRESCALER TO WATCH DOG 
	MOVWF OPTION_REG
	bcf INTCON,GIE

	BSF STATUS,RP1  ;SELECT BANK 3
	BCF EECON1, WREN ; Disable Write to EEDATA
	BCF STATUS, RP0 ; Select Bank 0
	BCF STATUS,RP1  ;SELECT BANK 0
;	goto Loop

	clrf TEMP4
	clrf PORTA
	clrf PORTB
g1
	call Dlay5
	decfsz TEMP4
	goto g1
	
	
START
	BCF Enable_LED  ; Pin2  - Clear LED buffers....
	BCF RESET_LED   ; Pin3
	BSF Enable_LED  ; Pin2
	NOP
	BCF Enable_LED  ; Pin2

	incf TEMP4,f
	incf TEMP5,f
	call   Dlay5                  ;  Wait 30 msecs before Reset
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	bcf    TEMP3, 0              ;  Clear Carry (Instruction Out)
 ; movlw 0x001;  Clear the Display RAM
 ;call SendINS
 ; movlw 0x003;  Clear the Display RAM
 ; call SendINS

	movlw  0x030 
               ;  Reset Command
	call SendINS             ;  Send the Nybble
	call Dlay5;  Wait 5 msecs before Sending Again
	EStrobe; 
	call Dlay160;  Wait 160 usecs before Sending the Third Time;
	EStrobe
	nop	
 ; call Dlay100
	movlw 0x038;  Note that it is a 2 Line Display
	call SendINS
 
	movlw 0x008;  Turn off the Display
	call SendINS
	movlw 0x001;  Clear the Display RAM
	call SendINS
	call Dlay5;  Note, Can take up to 4.1 msecs
	movlw 0x00e;  Turn the LCD Back On
	call SendINS
	movlw 0x006;  Enable Cursor Move Direction
	call SendINS
	movlw 0x080;  Set DD RAM Address to 0
	call SendINS
	call SendMessage
	movlw h'c0'
	call SendINS
	call SendMessage
	goto L2

SendMessage
	CLRF MCOUNTER	;Clear the pointer in  the table with text message
	
OutLoop
	
	call Message
	iorlw 0;  At the End of the Message?
	btfsc STATUS, Z
	goto L1;  Yes - Equal to Zero
	call SendCHAR;  Output the ASCII Character
	INCF MCOUNTER	;Move the pointer to next character in  the table with text message
	goto OutLoop
L1
  	return
  	
READ_TABLE
	BANKSEL EEADRH ; Select Bank of EEADRH
	MOVF ADDRH, W ;
	MOVWF EEADRH ; MS Byte of Program
; Address to read
	MOVF ADDRL, W ;
	MOVWF EEADR ; LS Byte of Program
; Address to read
	BANKSEL EECON1 ; Select Bank of EECON1
	BSF EECON1, EEPGD ; Point to PROGRAM
; memory
	BSF EECON1, RD ; EE Read
;
	NOP ; Any instructions
; here are ignored as
	NOP ; program memory is
; read in second cycle
; after BSF EECON1,RD
	BANKSEL EEDATA ; Select Bank of EEDATA
	MOVF EEDATH, W ; DATAH = EEDATH
	MOVWF DATAH
	MOVF EEDATA, W ; DATAL = EEDATA
	MOVWF DATAL ;
  	BCF STATUS, RP0 ; Select Bank 0
	BCF STATUS,RP1  ;SELECT BANK 0
	RETURN
	
Message1	
	dt "Sol v1", 0	
  	
Message;  Message to Output
	MOVLW HIGH (Message1) ; Ensure that PCLATH high has the
        MOVWF ADDRH ; correct value
        MOVLW LOW (Message1) ; Ensure that PCLATH high has the
        MOVWF ADDRL ; correct value
        MOVF MCOUNTER,W
        ADDWF ADDRL,F
        BTFSC STATUS,C
        INCF ADDRH,F
        CALL READ_TABLE	
        RETURN
        
SendCHAR;  Send the Character to the LCD - Data to send is in W Register!
 	call DateShift
	bsf R_S;  RS = 1
	nop
	nop
	nop
	nop
	EStrobe 
	call Dlay160
	MOVF DATAL,W
	return
  	
  	
L2
	movf TEMP4,w
	andlw h'0f'
	addlw h'30'
	call SendCHAR;  Output the ASCII Character
	
Read_Loop
	BCF RESET_LED   ; Pin3
	NOP		; Reset LED Shift Registers
	BSF RESET_LED   ; Pin3	
	MOVLW d'49'
	MOVWF  RCOUNTER	;Set Read Counter - 25 steps
	BSF Data
	ClockStrobe
RLoop1			;Cycle to set 25 1-s in shiftregister
	ClockStrobe
	decfsz	RCOUNTER,F
	goto RLoop1
	MOVLW d'25'
	MOVWF  RCOUNTER	;Set Read Counter - 25 steps
	BCF Data
	
RLoop2
	ClockStrobe
	BTFSC Button_Read	
	GOTO EndRead
	MOVF RCOUNTER,W
	MOVWF BUTTON_PRESSED
EndRead	
	decfsz	RCOUNTER,F
	goto RLoop2
	
ShowButton	
	movf BUTTON_PRESSED,W
	movwf DIGIT0
	movwf DIGIT0 +1	
	movwf DIGIT0 +2
	movwf DIGIT0 +3
	movwf DIGIT0 +4
	movwf DIGIT0 +5
	movwf DIGIT0 +6
	movwf DIGIT0 +7
	movwf DIGIT0 +8
	movwf DIGIT0 +9
	BSF DigitEnable1
	BSF DigitEnable4
	call SendLEDData
	call	Dlay160
	goto	Read_Loop	;Endless read a button and show it at DIGIT0
	
SendLEDData
	movlw d'12'
	movwf SCOUNTER	;Counter for 12 digits to send
SLoop1	
	movf	SCOUNTER,W
	addlw 	0x3f	;Add relative address of DIGIT0 - 1
	movwf	FSR
	movf INDF,w
	movwf	SEND_BUFFER
;1 bit
	BCF DATA
	rrf SEND_BUFFER,F
	BTFSS STATUS,C
	BSF DATA
	ClockStrobe
;2 bit	
	BCF DATA
	rrf SEND_BUFFER,F
	BTFSS STATUS,C
	BSF DATA
	ClockStrobe
;3 bit	
	BCF DATA
	rrf SEND_BUFFER,F
	BTFSS STATUS,C
	BSF DATA
	ClockStrobe
;4 bit	
	BCF DATA
	rrf SEND_BUFFER,F
	BTFSS STATUS,C
	BSF DATA
	ClockStrobe
	decfsz SCOUNTER,F
	GOTO SLoop1
	bsf	Enable_LED
	nop
	bcf	Enable_LED
	return
	
Loop;  Loop Forever when Done
;  gotoxy 11,1
	movlw h'8a'
	call SendINS
;  CALL Dlay5
	movf TEMP5,w
	andlw h'0f'
	addlw h'30'
	call SendCHAR;  Output the ASCII Character
	incf TEMP5,f                       
	call   Dlay5                  ;  Wait 30 msecs before Reset
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5               ;  Wait 30 msecs before Reset
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5                  ;  Wait 30 msecs before Reset
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	call   Dlay5
	btfss  Button_Read   ;BUTTON PRESSED?
	goto START
	goto   Loop

;  Subroutines


SendINS;  Send the Instruction to the LCD
;  movwf PORTB;  
	call DateShift
	bcf R_S;  RS = 0
	nop
	nop
	nop
	nop	
	EStrobe2 
	return

DateShift
	movwf	 NOTemp			;  Shift to Output
	movlw	 8			;  Set 8 Shifts
	movwf	 Dlay
NOLoop11
	rlf	 NOTemp,f		;  Shift Through the Nybble to Output
	bcf	 Data	
	btfsc  STATUS,C
	bsf    Data
	ClockStrobe
	decfsz Dlay
	goto	 NOLoop11
	return


Dlay160                         ;  Delay 160 usecs

	movlw  d'206'      ;  Loop Until Carry Set
	addlw  1
	btfss  STATUS, C
	goto  $-2
	return

Dlay40                         ;  Delay 40 usecs

	movlw  d'245'      ;  Loop Until Carry Set
	addlw  1
	btfss  STATUS, C
	goto  $-2
	return

Dlay100                         ;  Delay 100 usecs

	movlw  d'230'      ;  Loop Until Carry Set
	addlw  1
	btfss  STATUS, C
	goto  $-2
	return

Dlay4_1                           ;  Delay 4.1 msecs
	movlw  4                      ;  Set up the Delay
	movwf  Dlay
	movlw  50
	addlw  1	
	btfsc  STATUS, Z
	decfsz Dlay
	goto $-3
	return

Dlay1_64                           ;  Delay 1.64 msecs
	movlw  2                      ;  Set up the Delay
	movwf  Dlay
	movlw  91
	addlw  1
	btfsc  STATUS, Z
	decfsz Dlay
	goto $-3
	return

Dlay5                           ;  Delay 5 msecs

	movlw  4                      ;  Set up the Delay
	movwf  Dlay
	movlw  24
	addlw  1
	btfsc  STATUS, Z
	decfsz Dlay
	goto $-3
	return

;------------------------------
;lcd_gotoxy
;   input W = YYXXXXXX
;             76543210
;
;       Y    address
;      ---   -------
;       00    0
;       01    0x40
;       10    20 
;       11    0x40+20



lcd_gotoxy:
	movwf	Temp
	andlw	B'00111111'
	btfsc	Temp,6
	addlw	0x40
	btfsc	Temp,7
	addlw	.20
	iorlw	B'10000000'
	goto	SendINS;  

;------------------------------
lcd_cursor_off:
	movlw	B'00001100'		;display on,cursor off, blink off
	goto	SendINS;  

;------------------------------
lcd_cursor_on:
	movlw	B'00001111'		;display on,cursor on, blink on
	goto	SendINS;  



  end