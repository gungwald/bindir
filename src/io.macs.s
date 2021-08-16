
getKey      .macro keyValue
tryAgain    bit		KBD        ;TEST FOR KEY PRESSED
            bpl		tryAgain   ;WAIT FOR KEY PRESSED
            lda		KBD        ;GET THE KEY THAT WAS PRESSED
            bit		KBDSTRB    ;CLEAR KEYBOARD STROBE
            sta		keyValue   ;STORE THE KEY THAT WAS READ
            .endm
