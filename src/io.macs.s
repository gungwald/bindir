
GETKEY      .macro
            BIT   KBD        ;TEST FOR KEY PRESSED
            BPL   GETKEY     ;WAIT FOR KEY PRESSED
            LDA   KBD        ;GET THE KEY THAT WAS PRESSED
            BIT   KBDSTRB    ;CLEAR KEYBOARD STROBE
            STA   \0         ;STORE THE KEY THAT WAS READ
            .endm
