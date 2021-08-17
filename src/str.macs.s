;*******************************
; MACRO: COPY                  *
; COPIES A PASCAL-STYLE STRING *
; PREFIXED WITH A LENGTH BYTE  *
;*******************************
copy           .macro dest,src
               pushx
               lda      src     ;COPY LENGTH BYTE
               sta      dest    ;STORE LENGTH BYTE
               ldx      #0
next           cpx      src     ;CHECK IF LEN ]2 COPIED
               beq      done
               lda      src+1,X
               sta      dest+1,X
               inx
               jmp      next
done           popx
               .endm

;*******************************
;                              *
; MACRO: CONCAT PASCAL STRING  *
; ]1 - DESTINATION ADDRESS     *
; ]2 - SOURCE ADDRESS          *
;                              *
;*******************************
concat         .macro   dest,src
               pushxy
               ldx      dest         ;X HOLDS LEN DEST INDEX
               ldy      #0         ;Y HOLDS LEN SRC INDEX
next           cpy      src         ;CHECK IF LEN ]2 COPIED
               beq      done
               lda      src+1,Y     ;LOAD CHAR FROM SRC
               sta      dest+1,X     ;STORE TO DEST
               inx
               iny
               jmp      next
done           stx      dest         ;STORE THE COMBINED LEN
               popyx
               .endm

;*******************************
;                              *
; MACRO: GET FIRST ELEM OF     *
;        PREFIX                *
; ]1 - RESULT FIRST ELEMENT    *
; ]2 - PREFIX TO COPY FIRST    *
;      ELEMENT FROM            *
;                              *
;*******************************
FIRST          MAC
               PUSHXY
               LDX   #0
               CPX   ]2         ;CHECK IF AT END OF ]2 LEN
               BEQ   DONE
               LDA   ]2+1       ;DO FIRST SLASH SEPARATELY SO
               STA   ]1+1       ;A MATCH ON THE 2ND CAN TERM
NEXT           INX
               CPX   ]2         ;CHECK IF AT END OF LEN ]2
               BEQ   DONE
               LDA   ]2+1,X     ;LOAD CHAR
               STA   ]1+1,X     ;STORE CHAR
               CMP   #'/'       ;SLASH W/O HIGH BIT SET
               BNE   NEXT
               INX              ;ADD ONE FOR SLASH JUST COPIED
DONE           STX   ]1         ;SET LEN OF RESULT
               POPYX
               <<<

;*******************************
;                              *
; MACRO: PRINTS PASCAL STRING  *
; ]1 - STRING TO PRINT         *
;                              *
;*******************************
PRINT          MAC
               PUSHX
               LDX   #0
NEXT           CPX   ]1
               BEQ   DONE
               LDA   ]1+1,X
               ORA   #%10000000
               JSR   COUT
               INX
               JMP   NEXT
DONE           JSR   CROUT
               POPX
               <<<

;*******************************
;                              *
; MACRO: PUTS                  *
; DESCR: WRITES C-STYLE STRING *
;        TO THE SCREEN         *
; ]1 - THE STRING TO WRITE     *
;                              *
;*******************************
PUTS           MAC
               PUSHY
               LDY   #0
NEXT           LDA   ]1,Y       ;NEEDS Y NOT X FOR (VAR),Y MODE
               CMP   #0
               BEQ   DONE
               JSR   COUT
               INY
               JMP   NEXT
DONE           POPX
               <<<

:
