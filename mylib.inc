INCLUDE Irvine32.inc


printCard 	PROTO ,suit:DWORD, number:DWORD , site:COORD

showStatus 	PROTO , status:byte

printBackCard PROTO, site:COORD

Sleep 		PROTO, dwMilliseconds:DWORD

topBar 		PROTO, allMoney:DWORD , status:byte

loser		PROTO

; game
bs2	  		PROTO
twentyOne 	PROTO
ten		 	PROTO
sm			PROTO

.data
;------------------------------------------------------------
; output
outputHandle    DWORD 0 
cellsWritten    DWORD ? 
bytesWritten    DWORD 0
count           DWORD 0

; window
titleStr BYTE "ADULT ONLY",0
screen_size COORD <100,28>

; -----------------for main show------------------------------
xyPosition COORD <22,5>

; top bar
totalMoney DWORD ?

moneystr byte "$", 4 DUP(?)
now_playing  byte "Now playing: "
now_playing1 byte "Now playing: Black Jack"
now_playing2 byte "Now playing: Ten & thirty"
now_playing3 byte "Now playing: slot-machine"
now_playing4 byte "Now playing: big or small"
now_game byte ?
name0 byte 15 DUP(?)
buffer byte 15 DUP(0)
byteCount dword ?
bar1 byte "+-------------------------------------------------------------------------------------------------+"
bar2 byte "|"
bar3 byte "+-------------------------------------------------------------------------------------------------+"

; -----------------bottom PROC------------------------------
; bar
barBottom        byte "+--------------------------------------------------------------------------------------------------+"
barBottom2       byte "|                                                                                                  |"
noMoney			 byte "| You don't have so much money!!!                                                                  |"
zeroMoney		 byte "| You can't input 0                                                                                |"

; 1 : save bat money
inputMoneyStr   BYTE  "| Input money :                                                                                    |",0
betMoney        DWORD      ?
betMoneyStr		BYTE   4 dup (?)  
; 2 : final tied
wrTied 			BYTE  "| Tied!!!  You are so lucky~                                                                       |",0
; 3 : final get money
wrWin 			BYTE  "| You win!!!  Get $                                                                                |",0
; 3 : final lose money
wrLose 			BYTE  "| You lose ~ Lose $                                                                                |",0
;again
againStr1		BYTE  " Replay the game? (Yes:play, No:menu)  [ Yes ]    NO   ",0
againStr2		BYTE  " Replay the game? (Yes:play, No:menu)    Yes    [ NO ] ",0
againStatus		BYTE   1
; COORD
statusPosition  COORD    <0,21>  ; bottom status print
cursorPosition  COORD    <15,22> ; cursor position
againPosition	COORD	 <1,23>	 ; ask again print

;-------------------card PROC--------------------------------------
playerPosition   COORD   <2,10>
dealerPosition   COORD   <42,10>

CardTop    		BYTE 0DAh , (7 - 2) DUP(0C4h),0BFh
CardBody   		BYTE 0B3h , (7 - 2) DUP(' '), 0B3h
CardBottom 		BYTE 0C0h , (7 - 2) DUP(0C4h),0D9h

Card1Top    		BYTE 0DAh , (7 - 2) DUP(0C4h),0BFh
Card1Body   		BYTE 0B3h , (7 - 2) DUP('+'), 0B3h
Card1Bottom 		BYTE 0C0h , (7 - 2) DUP(0C4h),0D9h

;right
CardHR1   BYTE 0B3h , (7 - 4) DUP(' '), 3h,31h,0B3h
CardHR2   BYTE 0B3h , (7 - 4) DUP(' '), 3h,32h,0B3h
CardHR3   BYTE 0B3h , (7 - 4) DUP(' '), 3h,33h,0B3h
CardHR4   BYTE 0B3h , (7 - 4) DUP(' '), 3h,34h,0B3h
CardHR5   BYTE 0B3h , (7 - 4) DUP(' '), 3h,35h,0B3h
CardHR6   BYTE 0B3h , (7 - 4) DUP(' '), 3h,36h,0B3h
CardHR7   BYTE 0B3h , (7 - 4) DUP(' '), 3h,37h,0B3h
CardHR8   BYTE 0B3h , (7 - 4) DUP(' '), 3h,38h,0B3h
CardHR9   BYTE 0B3h , (7 - 4) DUP(' '), 3h,39h,0B3h
CardHR10  BYTE 0B3h , (7 - 5) DUP(' '), 3h,31h, 30h,0B3h
CardHRJ   BYTE 0B3h , (7 - 4) DUP(' '), 3h,4Ah,0B3h
CardHRQ   BYTE 0B3h , (7 - 4) DUP(' '), 3h,51h,0B3h
CardHRK   BYTE 0B3h , (7 - 4) DUP(' '), 3h,4Bh,0B3h
CardDR1   BYTE 0B3h , (7 - 4) DUP(' '), 4h,31h,0B3h
CardDR2   BYTE 0B3h , (7 - 4) DUP(' '), 4h,32h,0B3h
CardDR3   BYTE 0B3h , (7 - 4) DUP(' '), 4h,33h,0B3h
CardDR4   BYTE 0B3h , (7 - 4) DUP(' '), 4h,34h,0B3h
CardDR5   BYTE 0B3h , (7 - 4) DUP(' '), 4h,35h,0B3h
CardDR6   BYTE 0B3h , (7 - 4) DUP(' '), 4h,36h,0B3h
CardDR7   BYTE 0B3h , (7 - 4) DUP(' '), 4h,37h,0B3h
CardDR8   BYTE 0B3h , (7 - 4) DUP(' '), 4h,38h,0B3h
CardDR9   BYTE 0B3h , (7 - 4) DUP(' '), 4h,39h,0B3h
CardDR10  BYTE 0B3h , (7 - 5) DUP(' '), 4h,31h, 30h,0B3h
CardDRJ   BYTE 0B3h , (7 - 4) DUP(' '), 4h,4Ah,0B3h
CardDRQ   BYTE 0B3h , (7 - 4) DUP(' '), 4h,51h,0B3h
CardDRK   BYTE 0B3h , (7 - 4) DUP(' '), 4h,4Bh,0B3h
CardCR1   BYTE 0B3h , (7 - 4) DUP(' '), 5h,31h,0B3h
CardCR2   BYTE 0B3h , (7 - 4) DUP(' '), 5h,32h,0B3h
CardCR3   BYTE 0B3h , (7 - 4) DUP(' '), 5h,33h,0B3h
CardCR4   BYTE 0B3h , (7 - 4) DUP(' '), 5h,34h,0B3h
CardCR5   BYTE 0B3h , (7 - 4) DUP(' '), 5h,35h,0B3h
CardCR6   BYTE 0B3h , (7 - 4) DUP(' '), 5h,36h,0B3h
CardCR7   BYTE 0B3h , (7 - 4) DUP(' '), 5h,37h,0B3h
CardCR8   BYTE 0B3h , (7 - 4) DUP(' '), 5h,38h,0B3h
CardCR9   BYTE 0B3h , (7 - 4) DUP(' '), 5h,39h,0B3h
CardCR10  BYTE 0B3h , (7 - 5) DUP(' '), 5h,31h, 30h,0B3h
CardCRJ   BYTE 0B3h , (7 - 4) DUP(' '), 5h,4Ah,0B3h
CardCRQ   BYTE 0B3h , (7 - 4) DUP(' '), 5h,51h,0B3h
CardCRK   BYTE 0B3h , (7 - 4) DUP(' '), 5h,4Bh,0B3h
CardSR1   BYTE 0B3h , (7 - 4) DUP(' '), 6h,31h,0B3h
CardSR2   BYTE 0B3h , (7 - 4) DUP(' '), 6h,32h,0B3h
CardSR3   BYTE 0B3h , (7 - 4) DUP(' '), 6h,33h,0B3h
CardSR4   BYTE 0B3h , (7 - 4) DUP(' '), 6h,34h,0B3h
CardSR5   BYTE 0B3h , (7 - 4) DUP(' '), 6h,35h,0B3h
CardSR6   BYTE 0B3h , (7 - 4) DUP(' '), 6h,36h,0B3h
CardSR7   BYTE 0B3h , (7 - 4) DUP(' '), 6h,37h,0B3h
CardSR8   BYTE 0B3h , (7 - 4) DUP(' '), 6h,38h,0B3h
CardSR9   BYTE 0B3h , (7 - 4) DUP(' '), 6h,39h,0B3h
CardSR10  BYTE 0B3h , (7 - 5) DUP(' '), 6h,31h, 30h,0B3h
CardSRJ   BYTE 0B3h , (7 - 4) DUP(' '), 6h,4Ah,0B3h
CardSRQ   BYTE 0B3h , (7 - 4) DUP(' '), 6h,51h,0B3h
CardSRK   BYTE 0B3h , (7 - 4) DUP(' '), 6h,4Bh,0B3h

; Left
CardHL1   BYTE 0B3h , 3h,31h,(7 - 4) DUP(' '),0B3h
CardHL2   BYTE 0B3h , 3h,32h,(7 - 4) DUP(' '),0B3h
CardHL3   BYTE 0B3h , 3h,33h,(7 - 4) DUP(' '),0B3h
CardHL4   BYTE 0B3h , 3h,34h,(7 - 4) DUP(' '),0B3h
CardHL5   BYTE 0B3h , 3h,35h,(7 - 4) DUP(' '),0B3h
CardHL6   BYTE 0B3h , 3h,36h,(7 - 4) DUP(' '),0B3h
CardHL7   BYTE 0B3h , 3h,37h,(7 - 4) DUP(' '),0B3h
CardHL8   BYTE 0B3h , 3h,38h,(7 - 4) DUP(' '),0B3h
CardHL9   BYTE 0B3h , 3h,39h,(7 - 4) DUP(' '),0B3h
CardHL10  BYTE 0B3h , 3h,31h,30h,(7 - 5) DUP(' '),0B3h
CardHLJ   BYTE 0B3h , 3h,4Ah,(7 - 4) DUP(' '),0B3h
CardHLQ   BYTE 0B3h , 3h,51h,(7 - 4) DUP(' '),0B3h
CardHLK   BYTE 0B3h , 3h,4Bh,(7 - 4) DUP(' '),0B3h
CardDL1   BYTE 0B3h , 4h,31h,(7 - 4) DUP(' '),0B3h
CardDL2   BYTE 0B3h , 4h,32h,(7 - 4) DUP(' '),0B3h
CardDL3   BYTE 0B3h , 4h,33h,(7 - 4) DUP(' '),0B3h
CardDL4   BYTE 0B3h , 4h,34h,(7 - 4) DUP(' '),0B3h
CardDL5   BYTE 0B3h , 4h,35h,(7 - 4) DUP(' '),0B3h
CardDL6   BYTE 0B3h , 4h,36h,(7 - 4) DUP(' '),0B3h
CardDL7   BYTE 0B3h , 4h,37h,(7 - 4) DUP(' '),0B3h
CardDL8   BYTE 0B3h , 4h,38h,(7 - 4) DUP(' '),0B3h
CardDL9   BYTE 0B3h , 4h,39h,(7 - 4) DUP(' '),0B3h
CardDL10  BYTE 0B3h , 4h,31h,30h,(7 - 5) DUP(' '),0B3h
CardDLJ   BYTE 0B3h , 4h,4Ah,(7 - 4) DUP(' '),0B3h
CardDLQ   BYTE 0B3h , 4h,51h,(7 - 4) DUP(' '),0B3h
CardDLK   BYTE 0B3h , 4h,4Bh,(7 - 4) DUP(' '),0B3h
CardCL1   BYTE 0B3h , 5h,31h,(7 - 4) DUP(' '),0B3h
CardCL2   BYTE 0B3h , 5h,32h,(7 - 4) DUP(' '),0B3h
CardCL3   BYTE 0B3h , 5h,33h,(7 - 4) DUP(' '),0B3h
CardCL4   BYTE 0B3h , 5h,34h,(7 - 4) DUP(' '),0B3h
CardCL5   BYTE 0B3h , 5h,35h,(7 - 4) DUP(' '),0B3h
CardCL6   BYTE 0B3h , 5h,36h,(7 - 4) DUP(' '),0B3h
CardCL7   BYTE 0B3h , 5h,37h,(7 - 4) DUP(' '),0B3h
CardCL8   BYTE 0B3h , 5h,38h,(7 - 4) DUP(' '),0B3h
CardCL9   BYTE 0B3h , 5h,39h,(7 - 4) DUP(' '),0B3h
CardCL10  BYTE 0B3h , 5h,31h,30h,(7 - 5) DUP(' '),0B3h
CardCLJ   BYTE 0B3h , 5h,4Ah,(7 - 4) DUP(' '),0B3h
CardCLQ   BYTE 0B3h , 5h,51h,(7 - 4) DUP(' '),0B3h
CardCLK   BYTE 0B3h , 5h,4Bh,(7 - 4) DUP(' '),0B3h
CardSL1   BYTE 0B3h , 6h,31h,(7 - 4) DUP(' '),0B3h
CardSL2   BYTE 0B3h , 6h,32h,(7 - 4) DUP(' '),0B3h
CardSL3   BYTE 0B3h , 6h,33h,(7 - 4) DUP(' '),0B3h
CardSL4   BYTE 0B3h , 6h,34h,(7 - 4) DUP(' '),0B3h
CardSL5   BYTE 0B3h , 6h,35h,(7 - 4) DUP(' '),0B3h
CardSL6   BYTE 0B3h , 6h,36h,(7 - 4) DUP(' '),0B3h
CardSL7   BYTE 0B3h , 6h,37h,(7 - 4) DUP(' '),0B3h
CardSL8   BYTE 0B3h , 6h,38h,(7 - 4) DUP(' '),0B3h
CardSL9   BYTE 0B3h , 6h,39h,(7 - 4) DUP(' '),0B3h
CardSL10  BYTE 0B3h , 6h,31h,30h,(7 - 5) DUP(' '),0B3h
CardSLJ   BYTE 0B3h , 6h,4Ah,(7 - 4) DUP(' '),0B3h
CardSLQ   BYTE 0B3h , 6h,51h,(7 - 4) DUP(' '),0B3h
CardSLK   BYTE 0B3h , 6h,4Bh,(7 - 4) DUP(' '),0B3h


