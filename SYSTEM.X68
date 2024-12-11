*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
            ; INCLUDE "CONST.X68"

SYSINIT
            MOVE.L  (A7)+, A0               ; GET RETURN ADDRESS
            JSR     KBDINIT                 ; INIT KEYBOARD
            JSR     SCRINIT                 ; INIT SCREEN
            JSR     DMMINIT                 ; INIT DYNAMIC MEMORY
            ANDI.W  #$DFFF, SR              ; SWITCH TO USER
            MOVE.L  A0, -(A7)               ; PUT RETURN ADDRESS
            RTS

SCRINIT
            ORI.W   #$0700, SR              DISABLE INTERRUPTIONS
            MOVE.L  #SCRTRAP, D0
            MOVE.L  #SCRUPD, ($80+4*SCRTRAP)
            
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
            
            ; SET EXCETPION VECTOR & ENABLE EXCEPTION PROCESSING
            MOVE.L  #SCRISR, ($60+SCRIRQ*4)
            MOVE.B  #5, D1
            MOVE.B  #32, d0
            TRAP    #15
            
            ; ENABLE AUTO-IRQ
            MOVE.B  #%10000000|SCRIRQ,D2
            MOVE.B  #SCRTIM,D3
            MOVE.B  #6,D1
            MOVE.B  #32,D0
            TRAP    #15
            
            CLR.B   (SCRINTCT)              ; PREPARE INTERRUPT FLAG
            CLR.B   (SCRCYCCT)              ; PREPARE CYCLE COUNTER
            ANDI.W  #$F8FF,SR               ; ENABLE INTS
            RTS
            

SCRISR
            RTS
SCRUPD
            MOVEM.L D0-D1,-(A7)
            MOVEQ   #94,D0
            TRAP    #15
            MOVEQ   #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            MOVEM.L (A7)+,D0-D1
            RTE
            RTS
KBDINIT
            CLR.B   (KBDVAL)                 ; INIT VARS
            CLR.B   (KBDEDGE)
            MOVE.L  #KBDREAD,($80+KBDTRAP*4) ; INSTALL
            RTS

            RTS
KBREAD
            RTS
DMMINIT
            RTS







*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
