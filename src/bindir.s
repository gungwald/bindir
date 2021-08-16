;*******************************
;                              *
; BIN.DIR                      *
; (CMD.PGM.MAPR)               *
; BILL CHATFIELD               *
; APACHE LICENSE V2            *
;                              *
;*******************************

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
               copyw	EXTRNCMD+1,#<cmdHandler

               jsr  	getPrefix
               print	prefix

build_bindir
               first	bindir,prefix
               print	bindir
               concat   bindir,bin_slash
               print    bindir

               jsr      open
               print    opened

close_dir
               copyb	close_ref,bindir_ref
               jsr  	close
               print	closed

end_of_setup
               rts

;*******************************
;                              *
; EXTENDED COMMAND HANDLER     *
;                              *
;*******************************

cmdHandler

               rts

;*******************************
;                              *
; INCLUDE SUBROUTINES          *
;                              *
;*******************************
               .include "mli.calls.s"

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

