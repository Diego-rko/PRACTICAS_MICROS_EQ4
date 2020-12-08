; INSTITUTO POLITECNICO NACIONAL
; UPIITA
; uP, uC e I
; 7 DIC 2020
; CRD, FOLM, VVAD
; PRACTICA 2: SUBRUTINAS
; DAVID ARTURO GUTIERREZ BEGOVICH
; ESCRITO PARA PIC16F887 EN ENSAMBLADOR (MPLAB 8.91)

				PROCESSOR   16F887
				INCLUDE     <P16F887.INC>
					__CONFIG    0X2007, 0X2BC4
					__CONFIG    0X2008, 0X3FFF
					
					ORG	    0X0000
					BSF	    STATUS,RP0
					MOVLW	0XE7		;OSCILADOR A 4MHz
					MOVWF	OSCCON		;CONFIG OSCILADOR 
					CLRF 	TRISC		;PORT C SALIDA
					BCF		TRISB,4		;PORTB.4 SALIDA
					BCF		TRISB,7		;PORTB.7 SALIDA
					BSF		STATUS, RP1 ;BANCO 3
					CLRF	ANSELH	    ;
					CLRF 	ANSEL	    ;PA,PB Y PE=DIGITALES.
					BCF     STATUS,RP0  ; BANCO 2
					BCF     STATUS,RP1  ; BANCO 1
					
					
					
		;_______________________ PARTE A _____________________________
		
					CLRF 	PORTC		;LIMPIAR PORTC
					BCF		PORTB,7		;LIMPIAR PORTB,7
					BCF		TRISB,4		; LIMPIAR PORTB.4 (SALIDA)
					CALL	INI_SERVO
CASO0:				BTFSS	PORTB,0		; ¿PORTB=1?
					GOTO	CASO1
					GOTO	READ;
CASO1:				BTFSS	PORTB,1		; ¿PORTB=1?
					GOTO  	CASO2
					GOTO	PWM45
CASO2:				BTFSS	PORTB,2		; ¿PORTB=1?
					GOTO    CASO3
					GOTO	PWM90
CASO3:				BTFSS	PORTB,3		; ¿PORTB=1?
					GOTO  	CASO0		
					GOTO	PWM135
		
		;_______________________ INICIO DE SERVOMOTOR _____________________________
INI_SERVO:
					MOVLW	0X12
					MOVWF	0X50;CONTADOR1
REINICIO:			BSF		PORTB,4
					MOVLW	0X7C
					MOVWF	0X60
			; NOPS Faltantes
					CALL	ST0V
					BCF		PORTB,4
					MOVLW	0X0B
					MOVWF	0X61
				    MOVLW	0X44
					MOVWF	0X62
			; NOPS Faltantes
					CALL	ST2V
					DECF	0X50
					BTFSS	STATUS,Z
					GOTO	REINICIO
					RETURN
					
ST0V:
				   	NOP
					DECFSZ	0X60,F
					GOTO	ST0V
					RETURN
			
ST02V:				MOVF    0x62,W
					MOVWF	0X63
DECRE02V:
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
					DECFSZ	0X63,F
					GOTO	DECRE02V
					DECFSZ	0X61,F
					GOTO	ST02V
					RETURN
	
		;_______________________ PARTE B _____________________________	
		; 2.4 ms = 200°   0.4275 = 45° (más 0.5 ms de offset) tiempo=0,928 ms
PWM45:				BSF		PORTB,4
					MOVLW	0X99
					MOVWF	0X60
			; NOPS Faltantes
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
					CALL	ST1V
					BCF		PORTB,4
			 		MOVLW	0X0C
					MOVWF	0X61
				    MOVLW	0X42
					MOVWF	0X62
			; NOPS Faltantes
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
					CALL	ST2V
					GOTO	PWM45
			
ST1V:
				        NOP
				        NOP
				        NOP
					DECFSZ	0X60,F
					GOTO	ST1V
					RETURN
			 
			
ST2V:  				MOVF    0x62,W
					MOVWF	0X63
DECRE2V:
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
					DECFSZ	0X63,F
					GOTO	DECRE2V
					DECFSZ	0X61,F
					GOTO	ST2V
					RETURN
	
		;_______________________ PARTE C _____________________________
		; 1.9ms = 200°  1.355ms = 90° tiempo = 18.645ms
		
PWM90:				BSF		PORTB,4
					MOVLW	0XE1
					MOVWF	0X60
			; NOPS Faltantes
					CALL	ST12V
					BCF		PORTB,4
			 	 	MOVLW	0X4D
					MOVWF	0X61
				   	MOVLW	0X07
					MOVWF	0X62
			; NOPS Faltantes
				        NOP
				        NOP
				        NOP
				        NOP
					CALL	ST22V
					GOTO	PWM90
			
ST12V:
				        NOP
				        NOP
				        NOP
					DECFSZ	0X60,F
					GOTO	ST12V
					RETURN
		
ST22V:				MOVF    0x62,W
					MOVWF	0X63
DECRE22V:
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
					DECFSZ	0X63,F
					GOTO	DECRE22V
					DECFSZ	0X61,F
					GOTO	ST22V
					RETURN
	
		;_______________________ PARTE D _____________________________
		; 1.9ms = 200°  1.283 ms = 135° tiempo = 18.217ms
	
PWM135:				BSF		PORTB,4
					MOVLW	0XDE
					MOVWF	0X60
			; NOPS Faltantes
						NOP
					CALL	ST13V
					BCF		PORTB,4
			 	 	MOVLW	0X08
					MOVWF	0X61
				   	MOVLW	0X47
					MOVWF	0X62
			; NOPS Faltantes
				        NOP
				        NOP
					CALL	ST23V
					GOTO	PWM135
			
ST13V:
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
					DECFSZ	0X60,F
					GOTO	ST13V
					RETURN
			
ST23V:  			MOVF    0x62,W
					MOVWF	0X63
DECRE23V:
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
				        NOP
					DECFSZ	0X63,F
					GOTO	DECRE23V
					DECFSZ	0X61,F
					GOTO	ST23V
					RETURN
			;_______________________ PARTE E _____________________________
READ:					CALL  	ANTI_REBOTES	
WAIT:					BTFSC 	PORTB,0;
						GOTO  	WAIT
						CALL  	ANTI_REBOTES
						MOVF  	PORTD,W				;LEER PORTD
						MOVWF 	0X20				;DATO 1
READ2:					BTFSS 	PORTB,0
						GOTO  	READ2
						CALL  	ANTI_REBOTES	
WAIT2:					BTFSC 	PORTB,0;
						GOTO  	WAIT2
						CALL  	ANTI_REBOTES
						MOVF  	PORTD,W				;LEER PORTD
						MOVWF 	0X21					;DATO 2
READ3:					BTFSS 	PORTB,0
						GOTO  	READ3
						CALL  	ANTI_REBOTES	
WAIT3:					BTFSC 	PORTB,0;
						GOTO  	WAIT3
						CALL  	ANTI_REBOTES
						CALL 	LUCES
	
		;SUMAMOS DATO1 + DATO 2
						MOVF	0X20,W
						ADDWF	0X21,W
						MOVWF	0X23;
						BTFSS	STATUS,C
						GOTO	SHOW
						CALL	PARPADEO    ;GENERÓ ACARREO
						MOVF	0X23,W;		
SHOW:					MOVWF	PORTC
READ4:					BTFSS 	PORTB,0
						GOTO  	READ4
						CALL 	ANTI_REBOTES	
WAIT4:					BTFSC 	PORTB,0;
						GOTO  	WAIT4
						CALL  	ANTI_REBOTES		
						BCF	 	PORTB,7
						CALL	LUCES
	
		;RESTAMOS DATO1 - DATO 2
						MOVF  	0X21,W
						SUBWF	0X20,W
						MOVWF	0X23
						BTFSC	STATUS,C
						GOTO	SHOW2
						CALL	PARPADEO    ;RESULTADO NEGATIVO
						MOVF	0X23,W
						SUBLW 	0X00;
SHOW2:					MOVWF	PORTC
READ5:					BTFSS 	PORTB,0
						GOTO  	READ5
						CALL  	ANTI_REBOTES	
WAIT5:					BTFSC 	PORTB,0;
						GOTO  	WAIT5
						CALL  	ANTI_REBOTES		
						BCF	  	PORTB,7
						CALL 	LUCES

	;MULTIPLICAMOS DATO1 * DATO 2
						CLRF	0X24	;CONTADOR1
						MOVF	0X20,W
						MOVWF	0X22
						SUBLW	0X00
						BTFSC	STATUS,Z	;VER SI DATO1 ES CERO
						GOTO	SHOW3
						MOVF	0X21,W
						MOVWF	0X23
						SUBLW	0X00
						BTFSC	STATUS,Z	;VER SI DATO2 ES CERO
						GOTO	SHOW3
						MOVLW	0X01			
						SUBWF	0X22,F
						MOVF	0X23,W
								
REPETIR_M:				ADDWF	0X23,F		;F+W=>F
						BTFSS	STATUS,C
						GOTO	DECREMENTO
						MOVLW	0X01
						MOVWF	0X24;SE ACTIVA CONTADOR1
						MOVF	0X21,W
DECREMENTO:				DECF	0X22;									
						BTFSS	STATUS,Z;
						GOTO	REPETIR_M
						MOVF	0X24,W	
						SUBLW	0X00
						BTFSC	STATUS,Z; VERIFICAMOS RESTA ENTRE CONTADOR1 Y 0X00
						GOTO	SHOW3			
						CALL	PARPADEO
SHOW3:					MOVF	0X23,W
						MOVWF	PORTC
READ6:					BTFSS 	PORTB,0
						GOTO  	READ6
						CALL  	ANTI_REBOTES	
WAIT6:					BTFSC 	PORTB,0;
						GOTO  	WAIT6
						CALL  	ANTI_REBOTES		
						BCF	  	PORTB,7
						CALL 	LUCES		
	
			;DIVIDIMOS DATO1 /DATO 2
						MOVF	0X20,W
						SUBLW	0X00
						BTFSC	STATUS,Z	;VER SI DATO1 ES CERO
						GOTO	SHOW_D
						MOVF	0X21,W;
						SUBLW	0X00
						BTFSC	STATUS,Z	;VER SI DATO2 ES CERO
						GOTO	SHOW_D
						MOVF	0X21,W
						CLRF	0X21;
REPETIR_D:				INCF	0X21;
						SUBWF	0X20,F		;F-W=>F			
						BTFSC	STATUS,Z;
						GOTO	SHOW_D		
						BTFSC	STATUS,C		; C=>1?	
						GOTO	REPETIR_D			
						CALL	PARPADEO
						DECF	0X21    ;RESTAMOS UNO AL RESULTADO PARA REDONDEAR AL NUMERO MAS BAJO DE LA DIVISIÓN
SHOW_D:					MOVF	0X21,W
						MOVWF	PORTC;
				;PASOS 7 AL 16
READ7:					BTFSS 	PORTB,0
						GOTO  	READ7
						CALL  	ANTI_REBOTES	
WAIT7:					BTFSC 	PORTB,0;
						GOTO 	WAIT7
						CALL 	ANTI_REBOTES		
				; NUEVO DATO 1
						MOVF	PORTD,W
						MOVWF	0X20
READ8:					BTFSS	PORTB,0
						GOTO  	READ8
						CALL  	ANTI_REBOTES	
WAIT8:					BTFSC 	PORTB,0;
						GOTO  	WAIT8
						CALL  	ANTI_REBOTES		
				; NUEVO DATO 2
						MOVF	PORTD,W
						MOVWF	0X21	
READ9:					BTFSS 	PORTB,0
						GOTO  	READ9
						CALL  	ANTI_REBOTES	
WAIT9:					BTFSC 	PORTB,0;
						GOTO  	WAIT9
						CALL 	ANTI_REBOTES		
				; NUEVO DATO 3
						MOVF	PORTD,W
						MOVWF	0X22
READ10:					BTFSS 	PORTB,0
						GOTO  	READ10
						CALL  	ANTI_REBOTES	
WAIT10:					BTFSC 	PORTB,0;
						GOTO  	WAIT10
						CALL  	ANTI_REBOTES	
						BCF	  	PORTB,7
				;ENCENDER TODOS LOS LED´s

PASO12:					MOVLW	0XFF
						MOVWF	PORTC
				;LLAMADA A SUBRUTINA DE 3 VARIABLES
						CALL	SUBRUT3V
						CLRF	PORTC
				;LLAMADA A SUBRUTINA DE 3 VARIABLES
						CALL 	SUBRUT3V
						GOTO 	PASO12		
				
				;CARGAR LOS VALORES DE DATO1, DATO2 Y DATO 3
SUBRUT3V:
				;CARGAR LOS VALORES DE DATO1, DATO2 Y DATO 3
						MOVF	0X20,W
						MOVWF	0X64
						MOVF	0X21,W
						MOVWF	0X65
						MOVF	0X22,W
						MOVWF	0X66
SUBR3V:					MOVF	0X66,W
						MOVWF	0X67
REC31V:					MOVF    0x65,W
						MOVWF	0X68
DECRE31V:
					        NOP
					        NOP
					        NOP
						DECFSZ	0X68,F
						GOTO	DECRE31V
						DECFSZ	0X67,F
						GOTO	REC31V
						DECFSZ	0X64,F
						GOTO	SUBR3V
				
						RETURN
				
				
ANTI_REBOTES:
						MOVLW	0X8E
						MOVWF	0X61
				     	MOVLW	0X2B
						MOVWF	0X62
							NOP
ST7V:					MOVF    0x62,W
						MOVWF	0X63
DECRE24V:					NOP
						DECFSZ	0X63,F
						GOTO	DECRE24V
						DECFSZ	0X61,F
						GOTO	ST7V
						RETURN
				
LUCES:  				BCF		STATUS,C;
						CLRF	PORTC;
				;EMPIEZA DESPLAZAMIENTO
						CALL	DELAY_300MS
						MOVLW	0X01
						MOVWF	PORTC;
						CALL	DELAY_300MS
						RLF		PORTC,F;
						CALL	DELAY_300MS
						RLF		PORTC,F;
						CALL	DELAY_300MS
						RLF		PORTC,F;
						CALL	DELAY_300MS
						RLF		PORTC,F;
						CALL	DELAY_300MS
						RLF		PORTC,F;
						CALL	DELAY_300MS
						RLF		PORTC,F;
						CALL	DELAY_300MS
						RLF		PORTC,F;
						CALL	DELAY_300MS
						RRF		PORTC,F;
						CALL	DELAY_300MS
						RRF		PORTC,F;
						CALL	DELAY_300MS
						RRF		PORTC,F;
						CALL	DELAY_300MS
						RRF		PORTC,F;
						CALL	DELAY_300MS
						RRF		PORTC,F;
						CALL	DELAY_300MS
						RRF		PORTC,F;
						CALL	DELAY_300MS
						RRF		PORTC,F;
						CALL	DELAY_300MS
				;EMPIEZA CUENTA ASCENDENTE/DESCENDENTE
						MOVLW	0X03;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X07;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X0F;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X1F;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X3F;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X7F;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0XFF;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X7F;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X3F;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X1F;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X0F;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X07;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X03;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						MOVLW	0X01;
						MOVWF	PORTC;
						CALL	DELAY_300MS
						CLRF	PORTC;
						CALL	DELAY_300MS
						RETURN
				
PARPADEO:
						MOVLW	0XFF;
						MOVWF	PORTC;
						CALL DELAY_500MS	
						CLRF	PORTC;
						CALL DELAY_500MS
						MOVLW	0XFF;
						MOVWF	PORTC;
						CALL DELAY_500MS	
						CLRF	PORTC;
						CALL DELAY_500MS
						MOVLW	0XFF;
						MOVWF	PORTC;
						CALL DELAY_500MS	
						CLRF	PORTC;
						CALL DELAY_500MS
						MOVLW	0XFF;
						MOVWF	PORTC;
						CALL DELAY_500MS	
						CLRF	PORTC;
						CALL DELAY_500MS
						MOVLW	0XFF;
						MOVWF	PORTC;
						CALL DELAY_500MS	
						BSF	    PORTB,7;
				
						RETURN
						
				
DELAY_300MS:
				
						MOVLW	0X9A
						MOVWF	0X61
					    MOVLW	0XD8
						MOVWF	0X62
				; NOPS Faltantes
					    NOP
ST8V:			 		MOVF    0x62,W
						MOVWF	0X63
DECRE25V:
					        NOP
					        NOP
					        NOP
					        NOP
					        NOP
					        NOP
						DECFSZ	0X63,F
						GOTO	DECRE25V
						DECFSZ	0X61,F
						GOTO	ST8V
						RETURN
				
DELAY_500MS:
				
						MOVLW	0XEF
						MOVWF	0X61
					    MOVLW	0XE8
						MOVWF	0X62
				; NOPS Faltantes
					        NOP
					        NOP
					        NOP
					        NOP
					        NOP
ST9V:					MOVF    0x62,W
						MOVWF	0X63
DECRE26V:
					        NOP
					        NOP
					        NOP
					        NOP
					        NOP
					        NOP
						DECFSZ	0X63,F
						GOTO	DECRE26V
						DECFSZ	0X61,F
						GOTO	ST9V
						RETURN
						
						END