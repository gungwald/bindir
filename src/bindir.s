;*******************************
;                              *
; BIN.DIR                      *
; (CMD.PGM.MAPR)               *
; BILL CHATFIELD               *
; APACHE LICENSE V2            *
;                              *
;*******************************

                .code

; ORG $2000
; TYP $06        ;OUTPUT FILE TYPE IS BIN
; SAV /BINDIR/BINDIR

               .include "equates.s"
               .include "reg.macs.s"
               .include "str.macs.s"
               .include "io.macs.s"
               .include "mem.macs.s"

;*******************************
;                              *
; INITIAL LOAD TO SETUP THE    *
; EXTENDED COMMAND             *
;                              *
;*******************************

main
               copyw	nextCommand,EXTRNCMD+1
               copyw	EXTRNCMD+1,#<commandHandler

               jsr  	getPrefix
               print	prefix

buildBindir
               getVol	bindir,prefix
               print	bindir
               concat   bindir,binSlash
               print    bindir

               jsr      open
               print    opened

closeDir
               copyb	closeRef,bindirRef
               jsr  	close
               print	closed

endOfSetup
               rts

;*******************************
;                              *
; EXTENDED COMMAND HANDLER     *
;                              *
;*******************************

commandHandler

		rts

;*******************************
;                              *
; INCLUDE SUBROUTINES          *
;                              *
;*******************************
		.include "mli.calls.s"

                .data

;*******************************
;                              *
; VARIABLES                    *
;                              *
;*******************************

nextCommand	.word    0

opened		.byte	endOpened - openedChars		;Length byte
openedChars	.byte   "OPENED"
endOpened	.equ	*

closed		.byte	endClosed - closedChars		;Length byte
closedChars	.byte   "CLOSED"
endClosed

binSlash	.byte	endBinSlash - binSlashChars	;Length byte
binSlashChars	.byte   "BIN/"
endBinSlash	.equ	*

