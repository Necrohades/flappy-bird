*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
SYSINIT
            MOVE.L  (A7)+, A0               ; GET RETURN ADDRESS
            JSR     KBDINIT
            JSR     SCRINIT
            JSR     DMMINIT
            ANDI.W  #$DFFF, SR
            MOVE.L  A0, -(A7)

SCRINIT
            ORI.W   #$0700, SR              DISABLE INTERRUPTIONS
            MOVE.L  #SCRUPD, ($80+SCRTRAP*4)
            
            ; SET RESOLUTION
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH, D1
            MOVE.B  #33, D0
            TRAP    #15
            
            ; SET WINDOWED MODE
            MOVE.L  #1, D1
            TRAP    #15
            
            ; CLEAR VISIBLE BUFFER
            MOVE.W  #$FF00, D1
            MOVE.B  #11, D0
            TRAP    #15
            
            ; ENABLE DOUBLE BUFFER
            MOVE.B  #17, D1
            MOVE.B  #92, D0
            TRAP    #15
            
            ; CLEAR HIDDEN BUFFER
            MOVE.W  #$FF00, D1
            MOVE.B  #92, D0
            TRAP    #15
            
            MOVE.L  #SCRISR, ($60+SCRIRQ*4) SET EXCEPTION VECTOR
            MOVE.B  #5, D1                  ENABLE EXCEPTION PROCESSING
            MOVE.B  #32, D0
            TRAP    #15
            
            ; ENABLE AUTO-IRQ
            MOVE.B  #%10000000|SCRIRQ, D2
            MOVE.B  #SCRTIM, D3
            MOVE.B  #6, D1
            MOVE.B  #32, D0
            TRAP    #15
            
            CLR.B   (SCRINTCT)
            CLR.B   (SCRCYCCT)
            ANDI.W  #$F8FF, SR
            RTS
SCRISR
SCRUPD
KBDINIT
KBREAD
DMMINIT

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
