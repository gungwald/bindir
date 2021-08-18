;*******************************
;                              *
; MACRO: Copy byte             *
;                              *
;*******************************
copyb   .macro  dest,src
        lda	src
        sta	dest
        .endm

;*******************************
;                              *
; MACRO: Copy word             *
;                              *
;*******************************
copyw   .macro  dest,src
        lda	src
        sta	dest
        lda	src+1
        sta	dest+1
        .endm

