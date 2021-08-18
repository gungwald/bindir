getKey  .macro dest
        repeat
          bit   KBD     ;Test for key pressed
        until   mi      ;Until high bit is set
        lda     KBD     ;Get the key that was pressed
        bit     KBDSTRB ;Clear keyboard strobe
        sta     dest    ;Store the key that was read
        .endm
