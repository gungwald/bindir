
:  P  R  I  N  T  

********************************
*                              *
* BIN.DIR                      *
* (CMD.PGM.MAPR)               *
* BILL CHATFIELD               *
* APACHE LICENSE V2            *
*                              *
********************************

* ORG $2000
* TYP $06        ;OUTPUT FILE TYPE IS BIN
* SAV /BINDIR/BINDIR

               USE   EQUATES
               USE   REG.MACS
               USE   STR.MACS
               USE   IO.MACS
               USE   MEM.MACS

********************************
*                              *
* INITIAL LOAD TO SETUP THE    *
* EXTENDED COMMAND             *
*                              *
********************************

MAIN
               COPYA NEXT_COMMAND;EXTRNCMD+1
               COPYA EXTRNCMD+1;#<CMD_HANDLER

               JSR   GET_PREFIX
               PRINT PREFIX

BUILD_BINDIR
               FIRST BINDIR;PREFIX
               PRINT BINDIR
               concat   bindir,BIN_SLASH
               print    binDir

               jsr      OPEN
               print    opened

CLOSE_DIR
               COPYB CLOSE_REF;BINDIR_REF
               JSR   CLOSE
               PRINT CLOSED

END_OF_SETUP
               RTS

********************************
*                              *
* EXTENDED COMMAND HANDLER     *
*                              *
********************************

CMD_HANDLER

               RTS

********************************
*                              *
* INCLUDE SUBROUTINES          *
*                              *
********************************
               USE   MLI.CALLS

********************************
*                              *
* VARIABLES                    *
*                              *
********************************

NEXT_COMMAND
               DA    0

OPENED         STR   'OPENED'
CLOSED         STR   'CLOSED'

BIN_SLASH
               STR   'BIN/' ;LEN BYTE PREFIX, NO HI-BIT

:
