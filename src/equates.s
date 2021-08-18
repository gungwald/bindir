;*******************************
;                              *
; SYMBOLS REFERENCING SYSTEM   *
; RESOURCES                    *
;                              *
; AUTHOR:  BILL CHATFIELD      *
; LICENSE: GPL                 *
;                              *
;*******************************

CH          .equ   $24      ;HORIZ CHAR POS (40-COL)
BASL        .equ   $28      ;BASE ADDR FOR CURR VIDEO LINE
KSWL        .equ   $38      ;KEYBOARD SWITCH LOW BYTE
KSWH        .equ   $39      ;KEYBOARD SWITCH HIGH BYTE
IN          .equ   $200     ;256-CHAR INPUT BUFFER
OURCH       .equ   $57B     ;HORIZONTAL POSITION (80-COL)
OURCV       .equ   $5FB     ;VERTICAL POSITION (80-COL)

; ProDOS Addresses

EXTRNCMD    .equ   $BE06    ;VECTOR TO EXTERNAL COMMAND
PRINTERR    .equ   $BE0C    ;CAN'T GET THIS TO WORK
MLI         .equ   $BF00    ;ADDRESS OF MLI ENTRY POINT

; Memory Mapped Input/Output addresses C000 - CFFF

KBD         .equ   $C000    ;KEYBOARD DATA + STROBE
STOR80ON    .equ   $C001    ;ENABLE AUXILIARY MEM SWITCHING
CXROMOFF    .equ   $C006    ;ENABLE SLOT ROMS
CXROMON     .equ   $C007    ;TURN ON INTERNAL ROM
KBDSTRB     .equ   $C010    ;CLEAR KEYBOARD STROBE
ALTCHAR     .equ   $C01E    ;>=$80 IF IN 80-COL
PAGE2OFF    .equ   $C054    ;TURN ON MAIN MEMORY
PAGE2ON     .equ   $C055    ;TURN ON AUXILIARY MEMORY
BASICIN     .equ   $C305
BINPUT      .equ   $C8F6
ESCAPING    .equ   $C918
NOESC       .equ   $C9B7    ;HANDLES KEY OTHER THAN ESC
INVERT      .equ   $CEDD    ;80-col INVERT CHAR ON SCREEN
PICK        .equ   $CF01    ;80-col PICK CHAR OFF SCREEN

; Subroutines stored in ROM addresses D000 - FFFF

STROUT      .equ   $DB3A    ;BAS? PRINT NULL-TERM STR IN AY
HEXDEC      .equ   $ED24    ;HEX-TO-DECIMAL CONVERSION
PRINTXY     .equ   $F940    ;MONITOR PRINT X & Y AS HEX
RDKEY       .equ   $FD0C    ;READS 1 CHAR
KEYIN       .equ   $FD1B
RDCHAR      .equ   $FD35
GETLN       .equ   $FD6A
CROUT       .equ   $FD8E    ;PRINT A CARRIAGE RETURN
PRBYTE      .equ   $FDDA    ;MONITOR PRINT BYTE 2 HEX DIGITS
COUT        .equ   $FDED    ;WRITE A CHARACTER
BELL        .equ   $FF3A    ;SUBROUTINE TO BEEP

; Keyboard key code definitions

ESC         .equ   $9B      ;ESC WITH HIGH BIT SET
RTARROW     .equ   $95      ;RIGHT ARROW WITH HIGH BIT SET
DELETE      .equ   $FF      ;DELETE WITH HIGH BIT SET
BKSPACE     .equ   $88      ;BACKSPACE WITH HIGH BIT SET

