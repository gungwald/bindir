;*******************************
;                              *
; Macro: copy                  *
; Copies a pascal-style string *
; prefixed with a length byte  *
;                              *
;*******************************
copy    .macro  dest,src
        pushx
        lda     src         ;Copy length byte
        sta     dest        ;Store length byte
        ldx     #0
        repeat
          cpx   src         ;Check if len src copied
          break eq
          lda   src+1,X
          sta   dest+1,X
          inx
        forever
        popx
        .endm

;*******************************
;                              *
; Macro: Concat Pascal string  *
;                              *
;*******************************
concat  .macro  dest,src
        pushxy
        ldx     dest        ;X holds len dest index
        ldy     #0          ;Y holds len src index
        repeat
          cpy   src         ;Check if len src copied
          break eq
          lda   src+1,Y     ;Load char from src
          sta   dest+1,X    ;Store to dest
          inx
          iny
        forever
        stx     dest        ;Store the combined len
        popyx
        .endm

;*******************************
;                              *
; Macro: first                 *
; Descr: Gets first elem of    *
;        dir                   *
;                              *
;*******************************
first   .macro  result,dir
        pushx
        ldx     #0
        cpx     dir         ;Check if at end of len(dir)
        if ne
          lda   dir+1       ;Do first slash separately so
          sta   result+1    ;A match on the 2nd can term
          repeat
            inx
            cpx dir         ;Check if at end of len(dir)
            break eq
            lda dir+1,X     ;Load char
            sta result+1,X  ;Store char
            cmp #'/'        ;Slash w/o high bit set
          until eq
          cmp   #'/'        ;Check loop end condition
          if eq
            inx             ;Add one for if ended on slash
          endif
        endif
        stx     result      ;Set len of result
        popx
        .endm

;*******************************
;                              *
; Macro: Prints Pascal string  *
;                              *
;*******************************
print   .macro  strToPrint
        pushx
        ldx     #0
        repeat
          cpx   strToPrint      ;Compare X to length of strToPrint
          break eq
          lda   strToPrint+1,X
          ora   #%10000000
          jsr   COUT
          inx
        forever
        jsr     CROUT
        popx
        .endm

;*******************************
;                              *
; Macro: Puts                  *
; Descr: Writes c-style string *
;        to the screen         *
;                              *
;*******************************
puts    .macro  strToPut
        pushy
        ldy     #0
        repeat
          lda   strToPut,Y  ;Needs y not x for (var),y mode
          cmp   #0
          break eq
          jsr   COUT
          iny
        forever
        popy
        .endm

