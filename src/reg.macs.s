
:  P  R  I  N  T  

********************************
*                              *
* MAC: PUSH X REGISTER ON TO   *
*      STACK                   *
*                              *
********************************
PUSHX          MAC
               TXA
               PHA
               <<<

********************************
*                              *
* MAC: POPS X REGISTER FROM    *
*      STACK                   *
*                              *
********************************
popX    .macro
        pla
        tax
        .endm

********************************
*                              *
* MAC: PUSH Y REGISTER ON TO   *
*      STACK                   *
*                              *
********************************
PUSHY          MAC
               TYA
               PHA
               <<<

********************************
*                              *
* MAC: POPS Y REGISTER FROM    *
*      STACK                   *
*                              *
********************************
POPY           MAC
               PLA
               TAY
               <<<

********************************
*                              *
* PUSHES REGISTERS X AND Y     *
* ONTO THE STACK               *
*                              *
********************************
PUSHXY         MAC
               TXA
               PHA
               TYA
               PHA
               <<<

********************************
*                              *
* DOES THE REVERSE OF PUSHXY   *
*                              *
********************************
POPYX          MAC
               PLA
               TAY
               PLA
               TAX
               <<<

********************************
*                              *
* PUSHES WORD AT ]1 ONTO THE   *
* STACK                        *
*                              *
********************************
PUSHW          MAC
               LDA   ]1
               PHA
               LDA   ]1+1
               PHA
               <<<

********************************
*                              *
* POPS WORD INTO ADDRESS ]1    *
*                              *
********************************
POPW           MAC
               PLA
               STA   ]1+1
               PLA
               STA   ]1
               <<<

:
