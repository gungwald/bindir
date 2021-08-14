
********************************
*                              *
* PRODOS MLI SYSTEM CALLS      *
*                              *
********************************

MSG_ADDR             EQU        6

ON_LINE_ID           EQU        $C5
GET_PX_ID            EQU        $C7
OPEN_ID              EQU        $C8
CLOSE_ID             EQU        $CC


GET_PREFIX
               JSR   MLI
               DB    GET_PX_ID
               DA    GET_PX_PARAMS
               BEQ   GET_PX_OK
               JSR   WRITE_ERROR
               JMP   EXIT_PROGRAM
GET_PX_OK
               RTS


OPEN
               JSR   MLI
               DB    OPEN_ID
               DA    OPEN_PARAMS
               BEQ   OPEN_OK
               JSR   WRITE_ERROR
               JMP   EXIT_PROGRAM
OPEN_OK
               RTS


CLOSE
               JSR   MLI
               DB    CLOSE_ID
               DA    CLOSE_PARAMS
               BEQ   CLOSE_OK
               JSR   WRITE_ERROR
               JMP   EXIT_PROGRAM
CLOSE_OK
               RTS


EXIT_PROGRAM
               POPW  RETURN_ADDR
               RTS


RETURN_ADDR
               DA    0


WRITE_ERROR
               STA   ERROR_CODE

               PUSHXY
               PUSHW MSG_ADDR

               LDX   #0
               LDY   #0

:NEXT_CODE
               LDA   ERROR_CODE
               CMP   ERROR_CODES,X
               BEQ   :FOUND_CODE
               INX
               INY
               INY
               CPX   ERROR_COUNT
               BMI   :NEXT_CODE

:WRITE_UNK_ER
               LDA   #"("
               JSR   COUT
               PUTS  UNKNOWN_CODE
               LDA   ERROR_CODE
               JSR   PRBYTE
               LDA   #")"
               JSR   COUT
               JMP   :DONE

:FOUND_CODE
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

:DONE
               POPW  MSG_ADDR
               POPYX
               RTS


PREFIX         DS    65
BINDIR         DS    65
FILLER         DS    \          ;FILL WILL 0'S TO NEX PAGE
IOBUF          DS    1024       ;MUST START ON PAGE BOUNDAYR


GET_PX_PARAMS
               DB    1          ;PARAM COUNT
               DA    PREFIX     ;RESULT


OPEN_PARAMS
               DB    3          ;PARAM COUNT
               DA    BINDIR     ;INPUT PARMAETER
               DA    IOBUF      ;INPUT PARAMETER
BINDIR_REF
               DB    0          ;RESULT


CLOSE_PARAMS
               DB    1          ;PARAM COUNT
CLOSE_REF
               DB    0          ;INPUT


ERROR_CODE
               DB    0

UNKNOWN_CODE
               ASC   "UNKNOWN ERROR CODE: ",00

ERROR_COUNT
               DB    31

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
               DB    $00
               DB    $01
               DB    $03        ;BASIC code used improperly by AppleWin < 1.26.3
               DB    $04
               DB    $25
               DB    $27
               DB    $28
               DB    $2B
               DB    $2E
               DB    $40
               DB    $42
               DB    $43
               DB    $44
               DB    $45
               DB    $46
               DB    $47
               DB    $48
               DB    $49
               DB    $4A
               DB    $4B
               DB    $4C
               DB    $4D
               DB    $4E
               DB    $50
               DB    $51
               DB    $52
               DB    $54
               DB    $55
               DB    $56
               DB    $57
               DB    $5A

ERROR_MSGS
               DA    ERR00
               DA    ERR01
               DA    ERR03      ;BASIC code used improperly by AppleWin < 1.26.3
               DA    ERR04
               DA    ERR25
               DA    ERR27
               DA    ERR28
               DA    ERR2B
               DA    ERR2E
               DA    ERR40
               DA    ERR42
               DA    ERR43
               DA    ERR44
               DA    ERR45
               DA    ERR46
               DA    ERR47
               DA    ERR48
               DA    ERR49
               DA    ERR4A
               DA    ERR4B
               DA    ERR4C
               DA    ERR4D
               DA    ERR4E
               DA    ERR50
               DA    ERR51
               DA    ERR52
               DA    ERR53
               DA    ERR55
               DA    ERR56
               DA    ERR57
               DA    ERR5A

:
