; PRACTICA TONI FUENTES Y ALBERTO GALLEGO 
; ==============================================================================

            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
SCRTRAP     EQU     1                       ; SCREEN REFRESH TRAP

            ORG     $1000

            INCLUDE "VARS.X68"
            INCLUDE "SYSTEM.X68"
START:
            MOVE.L #SCRTRAP, D0             
            
            ; SET RESOLUTION
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH, D1
            MOVE.B  #33, D0
            TRAP    #15
            
            ; SET WINDOWED MODE
            MOVE.L  #1, D1
            TRAP    #15
            
            JSR     SYSINIT


    SIMHALT             
    END    START        





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
