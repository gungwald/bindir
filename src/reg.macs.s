;*******************************
;                              *
; .macro: PUSH X REGISTER ONTO *
;      STACK                   *
;                              *
;*******************************
pushx          .macro
               txa
               pha
               .endm

;*******************************
;                              *
; .macro: POPS X REGISTER FROM *
;      STACK                   *
;                              *
;*******************************
popx		.macro
		pla
		tax
		.endm

;*******************************
;                              *
; .macro: PUSH Y REGISTER ONTO *
;      STACK                   *
;                              *
;*******************************
pushy          .macro
               tya
               pha
               .endm

;*******************************
;                              *
; .macro: POPS Y REGISTER FROM *
;      STACK                   *
;                              *
;*******************************
popy           .macro
               pla
               tay
               .endm

;*******************************
;                              *
; PUSHES REGISTERS X AND Y     *
; ONTO THE STACK               *
;                              *
;*******************************
pushxy         .macro
               txa
               pha
               tya
               pha
               .endm

;*******************************
;                              *
; DOES THE REVERSE OF PUSHXY   *
;                              *
;*******************************
popyx          .macro
               pla
               tay
               pla
               tax
               .endm

;*******************************
;                              *
; PUSHES WORD AT ]1 ONTO THE   *
; STACK                        *
;                              *
;*******************************
pushw          .macro	addressOfWord
               lda	addressOfWord
               pha
               lda	addressOfWord+1
               pha
               .endm

;*******************************
;                              *
; POPS WORD INTO ADDRESS ]1    *
;                              *
;*******************************
popw           .macro	addressForWord
               pla
               sta	addressForWord+1
               pla
               sta	addressForWord
               .endm
