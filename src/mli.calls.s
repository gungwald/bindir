
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
               JSR   MLI
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
               POPW  RETURN_ADDR
               RTS


return_addr	.word    0


write_error
               STA   ERROR_CODE

               PUSHXY
               PUSHW MSG_ADDR

               LDX   #0
               LDY   #0

.NEXT_CODE
               LDA   ERROR_CODE
               CMP   ERROR_CODES,X
               BEQ   :FOUND_CODE
               INX
               INY
               INY
               CPX   ERROR_COUNT
               BMI   :NEXT_CODE

.WRITE_UNK_ER
               LDA   #"("
               JSR   COUT
               PUTS  UNKNOWN_CODE
               LDA   ERROR_CODE
               JSR   PRBYTE
               LDA   #")"
               JSR   COUT
               JMP   :DONE

.FOUND_CODE
               LDA   ERROR_MSGS,Y ;LOAD A WITH LOW BYTE OF MSG
               STA   MSG_ADDR     ;STORE LOW BYTE INTO LOLAC
               INY                ;ADVANCE TO HIGH BYTE
               LDA   ERROR_MSGS,Y ;LOAD A WITH HIGH BYTE GSM FO
               STA   MSG_ADDR+1   ;STORE HIGH BYTE INTO LLACO

               LDA   #"("
               JSR   COUT
               PUTS  (MSG_ADDR) ;WRITE THE ERROR MESSAGE
               LDA   #")"
               JSR   COUT

.DONE
               POPW  MSG_ADDR
               POPYX
               RTS


prefix         .space    65
bindir         .space    65
filler         .space    \          ;FILL WILL 0'S TO NEX PAGE
iobuf          .space    1024       ;MUST START ON PAGE BOUN.wordYR


getPrefixParams
               .byte    1          ;PARAM COUNT
               .word    prefix     ;RESULT


open_params
               .byte    3          ;PARAM COUNT
               .word    bindir     ;INPUT PARMAETER
               .word    iobuf      ;INPUT PARAMETER
bindir_ref
               .byte    0          ;RESULT


close_params
               .byte    1          ;PARAM COUNT
close_ref
               .byte    0          ;INPUT


ERROR_CODE
               .byte    0

UNKNOWN_CODE
               ASC   "UNKNOWN ERROR CODE: ",00

ERROR_COUNT
               .byte    31

ERR00          ASC   "NO ERROR",00
ERR01          ASC   "BAD SYSTEM CALL NUMBER",00
ERR03          ASC   "NO DEVICE CONNECTED",00 ;Bug in AppleWin < 1.26.3.0
ERR04          ASC   "BAD SYSTEM CALL PARAMETER COUNT",00
ERR25          ASC   "INTERRUPT VECTOR TABLE FULL",00
ERR27          ASC   "I/O ERROR",00
ERR28          ASC   "NO DEVICE CONNECTED",00
ERR2B          ASC   "DISK WRITE PROTECTED",00
ERR2E          ASC   "DISK SWITCHED: FILE STILL OPEN ON OTHER DISK",00
ERR40          ASC   "INVALID PATHNAME SYNTAX",00
ERR42          ASC   "FILE CONTROL BLOCK TABLE FULL",00
ERR43          ASC   "INVALID REFERENCE NUMBER",00
ERR44          ASC   "PATH NOT FOUND",00
ERR45          ASC   "VOLUME DIRECTORY NOT FOUND",00
ERR46          ASC   "FILE NOT FOUND",00
ERR47          ASC   "DUPLICATE FILENAME",00
ERR48          ASC   "OVERRUN ERROR: NOT ENOUGH DISK SPACE",00
ERR49          ASC   "DIRECTORY FULL",00
ERR4A          ASC   "INCOMPATIBLE FILE FORMAT",00
ERR4B          ASC   "UNSUPPORTED STORAGE TYPE",00
ERR4C          ASC   "END OF FILE HAS BEEN ENCOUNTERED",00
ERR4D          ASC   "POSITION OUT OF RANGE",00
ERR4E          ASC   "ACCESS ERROR: FILE ATTRIBUTE PREVENTS OPERATION",00
ERR50          ASC   "FILE IS OPEN",00
ERR51          ASC   "DIRECTORY COUNT ERROR: HEADER/ENTRY MISMATCH",00
ERR52          ASC   "NOT A PRODOS DISK",00
ERR53          ASC   "INVALID PARAMETER",00
ERR55          ASC   "VOLUME CONTROL BLOCK TABLE FULL",00
ERR56          ASC   "BAD BUFFER ADDRESS",00
ERR57          ASC   "DUPLICATE VOLUME",00
ERR5A          ASC   "BIT MAP DISK ADDRESS IS IMPOSSIBLE",00


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

:
