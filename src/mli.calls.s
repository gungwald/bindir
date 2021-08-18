
;*******************************
;                              *
; PRODOS MLI SYSTEM CALLS      *
;                              *
;*******************************

MSG_ADDR             .equ        6

ON_LINE_ID           .equ        $C5
GET_PREFIX_ID        .equ        $C7
OPEN_ID              .equ        $C8
CLOSE_ID             .equ        $CC


getPrefix
               jsr   MLI
               .byte    GET_PREFIX_ID
               .word    getPrefixParams
               BEQ	getPrefixOkay
               JSR   WRITE_ERROR
               JMP   EXIT_PROGRAM
getPrefixOkay
               RTS


open
               JSR   MLI
               .byte    OPEN_ID
               .word    OPEN_PARAMS
               BEQ	openOkay
               JSR   WRITE_ERROR
               JMP   EXIT_PROGRAM
openOkay
               RTS


close
               JSR   MLI
               .byte    CLOSE_ID
               .word    CLOSE_PARAMS
               BEQ   CLOSE_OK
               JSR   WRITE_ERROR
               JMP   EXIT_PROGRAM
close_ok
               RTS


exit_program
               popw  RETURN_ADDR
               RTS


return_addr	.word    0


write_error
               STA   ERROR_CODE

               pushxy
               pushw MSG_ADDR

               LDX   #0
               LDY   #0

.NEXT_CODE
               lda   ERROR_CODE
               cmp   ERROR_CODES,X
               beq   :FOUND_CODE
               inx
               iny
               iny
               cpx   ERROR_COUNT
               bmi   :NEXT_CODE

.WRITE_UNK_ER
               lda   #"("
               jsr   COUT
               puts  UNKNOWN_CODE
               lda   ERROR_CODE
               jsr   PRBYTE
               lda   #")"
               jsr   COUT
               jmp   :DONE

.FOUND_CODE
               lda   ERROR_MSGS,Y ;LOAD A WITH LOW BYTE OF MSG
               sta   MSG_ADDR     ;STORE LOW BYTE INTO LOLAC
               iny                ;ADVANCE TO HIGH BYTE
               lda   ERROR_MSGS,Y ;LOAD A WITH HIGH BYTE GSM FO
               sta   MSG_ADDR+1   ;STORE HIGH BYTE INTO LLACO

               lda   #"("
               jsr   COUT
               puts  (MSG_ADDR) ;WRITE THE ERROR MESSAGE
               lda   #")"
               jsr   COUT

.DONE
               popw  MSG_ADDR
               popyx
               rts


prefix  .space    65
bindir  .space    65
filler  .space    \          ;FILL WILL 0'S TO NEX PAGE
iobuf   .space    1024       ;MUST START ON PAGE BOUN.wordYR


getPrefixParams
                .byte    1          ;PARAM COUNT
                .word    prefix     ;RESULT


open_params     .byte    3          ;PARAM COUNT
                .word    bindir     ;INPUT PARMAETER
                .word    iobuf      ;INPUT PARAMETER
bindir_ref      .byte    0          ;RESULT


close_params    .byte    1          ;PARAM COUNT
close_ref       .byte    0          ;INPUT


ERROR_CODE      .byte    0
UNKNOWN_CODE    .byte   "UNKNOWN ERROR CODE: ",00
ERROR_COUNT     .byte    31

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


ERROR_CODES
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

ERROR_MSGS
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

