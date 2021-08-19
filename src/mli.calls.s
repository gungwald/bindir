;*******************************
;                              *
; PRODOS MLI SYSTEM CALLS      *
;                              *
;*******************************

MSG_ADDR	.equ	6
IOBUF		.equ	$4000

ON_LINE_ID	.equ	$C5
GET_PREFIX_ID	.equ	$C7
OPEN_ID		.equ	$C8
CLOSE_ID	.equ	$CC


getPrefix	jsr	MLI
		.byte	GET_PREFIX_ID
		.word	getPrefixParams
		beq	getPrefixOkay
		jsr	writeError
		jmp	exitProgram
getPrefixOkay	rts


open		jsr	MLI
		.byte	OPEN_ID
		.word	openParams
		beq	openOkay
		jsr	writeError
		jmp	exitProgram
openOkay	rts


close		jsr	MLI
		.byte	CLOSE_ID
		.word	closeParams
		beq	closeOkay
		jsr	writeError
		jmp	exitProgram
closeOkay	rts


exitProgram	popw	returnAddress
		rts


returnAddress	.word	0


writeError 	sta	errorCode
		pushxy
		pushw	MSG_ADDR

		ldx	#0
		ldy	#0

.nextCode	lda	errorCode
		cmp	errorCodes,X
		beq	.foundCode
		inx
		iny
		iny
		cpx	errorCount
		bmi	.nextCode

.writeUnkError	lda	#"("
		jsr	COUT
		puts	unknownCode
		lda	errorCode
		jsr	PRBYTE
		lda	#")"
		jsr	COUT
		jmp	.done

.foundCode	lda	errorMessages,Y	;Load a with low byte of msg
		sta	MSG_ADDR	;Store low byte into lolac
		iny			;Advance to high byte
		lda	errorMessages,Y	;Load a with high byte gsm fo
		sta	MSG_ADDR+1	;Store high byte into llaco

		lda	#"("
		jsr	COUT
		puts	(MSG_ADDR)	;Write the error message
		lda	#")"
		jsr	COUT

.done		popw	MSG_ADDR
		popyx
		rts


prefix  	.space	65
bindir  	.space	65


getPrefixParams .byte	1          ;Param count
                .word	prefix     ;Result


openParams      .byte	3          ;Param count
                .word	bindir     ;Input parmaeter
                .word	IOBUF      ;Input parameter
bindirRef 	.byte	0          ;Result


closeParams     .byte	1          ;Param count
closeRef        .byte	0          ;Input


errorCode	.byte	0
unknownCode	.byte	"UNKNOWN ERROR CODE: ",00
errorCount	.byte	31

ERR00   .byte   "NO ERROR",00
ERR01   .byte   "BAD SYSTEM CALL NUMBER",00
ERR03   .byte   "NO DEVICE CONNECTED",00 ;Bug in AppleWin < 1.26.3.0
ERR04   .byte   "BAD SYSTEM CALL PARAMETER COUNT",00
ERR25   .byte   "INTERRUPT VECTOR TABLE FULL",00
ERR27   .byte   "I/O ERROR",00
ERR28   .byte   "NO DEVICE CONNECTED",00
ERR2B   .byte   "DISK WRITE PROTECTED",00
ERR2E   .byte   "DISK SWITCHED: FILE STILL OPEN ON OTHER DISK",00
ERR40   .byte   "INVALID PATHNAME SYNTAX",00
ERR42   .byte   "FILE CONTROL BLOCK TABLE FULL",00
ERR43   .byte   "INVALID REFERENCE NUMBER",00
ERR44   .byte   "PATH NOT FOUND",00
ERR45   .byte   "VOLUME DIRECTORY NOT FOUND",00
ERR46   .byte   "FILE NOT FOUND",00
ERR47   .byte   "DUPLICATE FILENAME",00
ERR48   .byte   "OVERRUN ERROR: NOT ENOUGH DISK SPACE",00
ERR49   .byte   "DIRECTORY FULL",00
ERR4A   .byte   "INCOMPATIBLE FILE FORMAT",00
ERR4B   .byte   "UNSUPPORTED STORAGE TYPE",00
ERR4C   .byte   "END OF FILE HAS BEEN ENCOUNTERED",00
ERR4D   .byte   "POSITION OUT OF RANGE",00
ERR4E   .byte   "ACCESS ERROR: FILE ATTRIBUTE PREVENTS OPERATION",00
ERR50   .byte   "FILE IS OPEN",00
ERR51   .byte   "DIRECTORY COUNT ERROR: HEADER/ENTRY MISMATCH",00
ERR52   .byte   "NOT A PRODOS DISK",00
ERR53   .byte   "INVALID PARAMETER",00
ERR55   .byte   "VOLUME CONTROL BLOCK TABLE FULL",00
ERR56   .byte   "BAD BUFFER ADDRESS",00
ERR57   .byte   "DUPLICATE VOLUME",00
ERR5A   .byte   "BIT MAP DISK ADDRESS IS IMPOSSIBLE",00


errorCodes
        .byte    $00
        .byte    $01
        .byte    $03        ;BASIC code used improperly by AppleWin < 1.26.3
        .byte    $04
        .byte    $25
        .byte    $27
        .byte    $28
        .byte    $2B
        .byte    $2E
        .byte    $40
        .byte    $42
        .byte    $43
        .byte    $44
        .byte    $45
        .byte    $46
        .byte    $47
        .byte    $48
        .byte    $49
        .byte    $4A
        .byte    $4B
        .byte    $4C
        .byte    $4D
        .byte    $4E
        .byte    $50
        .byte    $51
        .byte    $52
        .byte    $54
        .byte    $55
        .byte    $56
        .byte    $57
        .byte    $5A

errorMessages
        .word    ERR00
        .word    ERR01
        .word    ERR03      ;BASIC code used improperly by AppleWin < 1.26.3
        .word    ERR04
        .word    ERR25
        .word    ERR27
        .word    ERR28
        .word    ERR2B
        .word    ERR2E
        .word    ERR40
        .word    ERR42
        .word    ERR43
        .word    ERR44
        .word    ERR45
        .word    ERR46
        .word    ERR47
        .word    ERR48
        .word    ERR49
        .word    ERR4A
        .word    ERR4B
        .word    ERR4C
        .word    ERR4D
        .word    ERR4E
        .word    ERR50
        .word    ERR51
        .word    ERR52
        .word    ERR53
        .word    ERR55
        .word    ERR56
        .word    ERR57
        .word    ERR5A

