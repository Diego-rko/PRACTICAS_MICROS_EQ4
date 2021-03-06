;INSTITUTO POLITECNICO NACIONAL
;UPIITA
;uP, uC e I
;11-DIC-2020
;CERVANTES RODRIGUEZ DIEGO
;FERNANDEZ OLVERA LINDA MARIA
;VIDALS VAZQUEZ ANGEL DAVID
;TAREA: MODO INDIRECTO
;PROFESOR DAVID ARTURO GUTIERREZ BEGOVICH
;ESCRITO PARA PIC16F887 EN ENSAMBLADOR (MPLAB)

				PROCESSOR		16F887
				__CONFIG		0X2007,0X2BE4
				__CONFIG		0X2008,0X3FFF
				INCLUDE			<P16F887.INC>
				ORG				0X00

				CLRF	    PORTA
				CLRF	    PORTB
				CLRF	    PORTC
				CLRF	    PORTD
				CLRF	    PORTE
				BSF	    STATUS,RP0	    ;B1
				BSF	    STATUS,RP1	    ;B3
				CLRF	    ANSELH	    ;
				CLRF	    ANSEL	    ;PA,PB Y PE=DIG
				CLRF	    STATUS	    ;B0

				CLRF	    0X71	    ;LIMPIAR REG 0X71
				BCF	    STATUS,IRP	    ;CARGAMOS EL BIT 7 DE STATUS(IRP) CON 0 PARA USURPAR REGISTROS DEL BANCO 0 Y 1
				MOVLW	    0X20	    ;W CON 0X20
				MOVWF	    FSR		    ;W REG FSR 

CARGAR1:			MOVWF		INDF	    ;W A INDF, CONTIENE FSR
				INCF		FSR,F	    ;AUMENTAMOS 1 LA BANDERA Y LA GUARDAMOS EN SI MISMO

				MOVLW		0X70	    ;FINAL
				XORWF		FSR,W	    ;COMPARA SI EL VALOR ES EL MISMO QUE EL NUMERO FINAL
				BTFSC		STATUS,Z    ;Z=?
				GOTO		EXIT1	    ;EXIT
				ANDLW		0X0F	    ;CONSERVAR VALORES 
				MOVWF		0X71	    ; W AL REG 0X71
				CLRW			
				ADDWF		FSR,W	    ;A�ADIR FSR Y GUARDA EN W
				ANDLW		0XF0	    ;CONSERVAR VALORES 
				ADDWF		0X71,W	    ;SUMA A W EL REG 0X71 Y SE GUARDA EN  W
				GOTO		CARGAR1	    ;REPETIR 
				
EXIT1:
							
				CLRF		0X71	    ;LIMPIAR EL REG 0X71
				MOVF		FSR,W	    ;MOVER A W EL REG FSR
				MOVWF		0X72	    ;MOVER W AL REG 0X72
				CLRW		
				BCF		STATUS,IRP		
				MOVLW		0XA0
				MOVWF		FSR
				CLRW
				MOVF		0X72,W	    ;MOVER REG 0X72 A W

CARGAR2:			MOVWF		INDF
				INCF		FSR,F

				MOVLW		0XF0			
				XORWF		FSR,W
				BTFSC		STATUS,Z		
				GOTO		EXIT2
				INCF		0X72	    ;INCREMENTA VALOR REG 0X72
				MOVF		0X72,W	    ;MOVER INCREMENTO A W
				GOTO		CARGAR2
				
EXIT2:				
				;0X110 - 0X170
				INCF		0X72,F	    ;INCREMENTAR VALOR DEL REG 0X72 
				BSF		STATUS,IRP
				MOVLW		0X110
				MOVWF		FSR
				CLRW
				MOVF		0X72,W	    ;MOVER A W EL VALOR DEL REG 0X72

CARGAR3:			MOVWF		INDF			
				INCF		FSR,F

				MOVLW		0X170
				XORWF		FSR,W
				BTFSC		STATUS,Z
				GOTO		EXIT3
				INCF		0X72	    ;INCREMENTAR +1 REG 0X72
				MOVF		0X72,W	    ;GUARDAR VALOR DEL REG A W		
				GOTO		CARGAR3

EXIT3:				
				
				INCF		0X72,F	    ;INCREMENTAR VALOR DEL REG 0X72 +1 
				BSF		STATUS,IRP
				MOVLW		0X190
				MOVWF		FSR
				CLRW
				MOVF		0X72,W	    ;MOVER VALOR DE REG 0X72 A W

CARGAR4:			MOVWF		INDF
				INCF		FSR,F

				MOVLW		0X1F0
				XORWF		FSR,W
				BTFSC		STATUS,Z    ; Z=?
				GOTO		FIN	    ;FINAL
				INCF		0X72	    ;INCREMENTAR VALOR DEL REG 0X72
				MOVF		0X72,W	    ;MOVER EL VALOR DEL REG 0X72 A W
				GOTO		CARGAR4
FIN:						
				GOTO		$	
				END

