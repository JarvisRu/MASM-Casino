TITLE FP (FP.asm)

;INCLUDE Irvine32.inc
INCLUDE mylib.inc

WriteConsoleOutputAttribute PROTO,
	outHandle:DWORD,					
	pAttribute:PTR WORD,				
	nLength:DWORD,					
	xyCoord:COORD,					
	lpCount:PTR DWORD				

WriteConsoleOutputCharacter PROTO,
	handleScreenBuf:DWORD,			
	pBuffer:PTR BYTE,				
	bufsize:DWORD,					
	xyPos:COORD,					
	pCount:PTR DWORD	

SetConsoleTitle PROTO, titleStr :PTR BYTE

SetConsoleScreenBufferSize PROTO,
	outHandle:DWORD,				; handle to screen buffer
	dwSize:COORD				; new screen buffer size
	

print_title PROTO, 
		string:ptr, position:COORD
print_name PROTO, 
		string:ptr, position:COORD
print_age PROTO, 
		string:ptr, position:COORD
		
print_stop PROTO, 
		string:ptr, position:COORD
print_R PROTO, 
		string:ptr, position:COORD
		
printstr PROTO, 
		string:ptr, position:COORD
print_stop PROTO, 
		string:ptr, position:COORD
	
.data 

attributes0 WORD 10 DUP(0Ch)

subtopic byte "-press enter-"
topic1  byte " ______     _____     __  __     __        ______  "
topic2  byte "/\  __ \   /\  __-.  /\ \/\ \   /\ \      /\__  _\ "
topic3  byte "\ \  __ \  \ \ \/\ \ \ \ \_\ \  \ \ \____ \/_/\ \/ "
topic4  byte " \ \_\ \_\  \ \____-  \ \_____\  \ \_____\   \ \_\ "
topic5  byte "  \/_/\/_/   \/____/   \/_____/   \/_____/    \/_/ "
topic6  byte "      ______     __   __     __        __  __      "
topic7  byte "     /\  __ \   /\ \-.\ \   /\ \      /\ \_\ \     "
topic8  byte "     \ \ \/\ \  \ \ \-.  \  \ \ \____ \ \____ \    "
topic9  byte "      \ \_____\  \ \_\\'\_\  \ \_____\ \/\_____\   "
topic10 byte "       \/_____/   \/_/ \/_/   \/_____/  \/_____/   "


age0 sdword ?

top_bar byte "+-----------------+   +-----------------+   +------------------+   +------------------+"
bodybar byte "|                 |   |                 |   |                  |   |                  |"
 
BJ   byte "    Black Jack    "
tenStr  byte "       10.5       "
slot byte "   Slot machine   "
big  byte "    Big or small  "

pick_BJ   byte "   [Black Jack]   "
pick_ten  byte "      [10.5]      "
pick_slot byte "  [Slot machine]  "
pick_big  byte "   [Big or small] "

; game icon---------------------------------------------------------------------
BJ1 byte "  .oooo.     .o  "
BJ2 byte ".dP''Y88b  o888  "
BJ3 byte "      ]8P'  888  "
BJ4 byte "    .d8P'   888  "
BJ5 byte "  .dP'      888  "
BJ6 byte ".oP     .o  888  "
BJ7 byte "8888888888 o888o "

tenthirty1 byte "   ~~~~~~~~~~~   "
tenthirty2 byte "   .'11 12 1'.   "
tenthirty3 byte "   :10\     2:   "
tenthirty4 byte "   :9  \@   3:   "
tenthirty5 byte "   :8   |   4;   "
tenthirty6 byte "   '..7 6 5..'   "
tenthirty7 byte "   ~~~~~~~~~~~   "

BG1 byte "                 "
BG2 byte "  Yb         .dP "
BG3 byte "   `Yb     .dP   "
BG4 byte "     `Yb  dP     "
BG5 byte "     .dP  Yb     "
BG6 byte "   .dP     `Yb   "
BG7 byte "  dP         `Yb "

sl1 byte "   +--------+   "
sl2 byte "   | CASINO |   "
sl3 byte "   |--------|  O"
sl4 byte "   |  7777  | / "
sl5 byte "   |--------|/  "
sl6 byte "   |    [_] |   "
sl7 byte "   +--------+   "

stop1  byte "            uuuuuuuuuuuuuuuuuuuu            "
stop2  byte "          u' uuuuuuuuuuuuuuuuuu 'u          "
stop3  byte "        u' u$$$$$$$$$$$$$$$$$$$$u 'u        "
stop4  byte "      u' u$$$$$$$$$$$$$$$$$$$$$$$$u 'u      "
stop5  byte "    u' u$$$$$$$$$$$$$$$$$$$$$$$$$$$$u 'u    "
stop6  byte "  u' u$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$u 'u  "
stop7  byte "u' u$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$u 'u"
stop8  byte "$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $"
stop9  byte "$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $"
stop10 byte "$ $$$' ... '$...  ...$' ... '$$$  ... '$$$ $"
stop11 byte "$ $$$u `'$$$$$$$  $$$  $$$$$  $$  $$$  $$$ $"
stop12 byte "$ $$$$$$uu '$$$$  $$$  $$$$$  $$  ''' u$$$ $"
stop13 byte "$ $$$''$$$  $$$$  $$$u '$$$' u$$  $$$$$$$$ $"
stop14 byte "$ $$$$....,$$$$$..$$$$$....,$$$$..$$$$$$$$ $"
stop15 byte "$ $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ $"
stop16 byte "'u '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$' u'"
stop17 byte " 'u '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$' u'  "
stop18 byte "   'u '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$' u'    "
stop19 byte "     'u '$$$$$$$$$$$$$$$$$$$$$$$$$' u'      "
stop20 byte "       'u '$$$$$$$$$$$$$$$$$$$$$' u'        "
stop21 byte "         'u  uuuuuuuuuuuuuuuuuu u'          "
stop22 byte "            uuuuuuuuuuuuuuuuuuuu            "

adult_only byte "Adult only, please leave."

rule1 byte "Welcome to Adult Only Casino!!"
rule2 byte "We have four games for you to choose: "
rule3 byte "1. BlackJack, also known as twenty-one points. J/Q/K stands for 10."
rule4 byte "	   The winner is the player who has the most points, but the points must smaller than 21."
rule5 byte "2. TenThirty,The winner is the player who has the most points,but the points must smaller than 10.5"
rule6 byte "	   While J/Q/K stands for 0.5."
rule7 byte "3. Slot machine, is a casino gambling machine with 4 reels which spin when a button is pushed."
rule8 byte "4. Big or samll, there are 3 cards you can choose, "
rule9 byte "   If the card you chose is bigger than dealer, you win!"
rule10 byte "You will get 500 at start. Good luck~"

age byte "Please enter your age:"

.code
; proc--------------------------------------------------------------------------
print_title PROC uses ecx, 
		string:ptr, position:COORD
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   				
		string,   				
		51,   						
		position,   					
		ADDR count
	inc xyPosition.y
	ret
print_title ENDP 

print_name PROC, 
		string:ptr, position:COORD
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   				
		string,   					
		69,   						
		position,   						
		ADDR count
	inc xyPosition.y
	ret
print_name ENDP

print_age PROC, 
		string:ptr, position:COORD
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		string,   					
		25,   						
		position,   					
		ADDR count
	inc xyPosition.y
	ret
print_age ENDP

printstr PROC uses ecx, 
		string:ptr, position :COORD
		
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		string,   						
		17,   						
		xyPosition,   						
		ADDR count 
	inc xyPosition.y
	ret
printstr ENDP

print_R PROC, 
		string:ptr, position:COORD
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		string,   						
		18,   						
		xyPosition,   						
		ADDR count
	add xyPosition.x, 22
	ret
print_R ENDP

print_stop PROC, 
		string:ptr, position:COORD
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		string,   						
		44,   						
		position,   						
		ADDR count
	inc xyPosition.y
	ret
print_stop ENDP


;main-----------------------------------------------------------------------

start@0 PROC
INVOKE GetStdHandle, STD_OUTPUT_HANDLE  
    mov outputHandle, eax 				
    call Clrscr

INVOKE SetConsoleTitle, ADDR titleStr	
INVOKE SetConsoleScreenBufferSize, outputHandle, screen_size

; ----------------------Page1------------------------------------------------------	
P1_adultonly:
	INVOKE print_title, addr topic1, xyPosition
	INVOKE print_title, addr topic2, xyPosition
	INVOKE print_title, addr topic3, xyPosition
	INVOKE print_title, addr topic4, xyPosition
	INVOKE print_title, addr topic5, xyPosition
	INVOKE print_title, addr topic6, xyPosition
	INVOKE print_title, addr topic7, xyPosition
	INVOKE print_title, addr topic8, xyPosition
	INVOKE print_title, addr topic9, xyPosition
	INVOKE print_title, addr topic10, xyPosition

	add xyPosition.y, 2
	mov xyPosition.x, 42
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; console output handle
		ADDR subtopic,   						; pointer to the top box line
		sizeof subtopic,   						; size of box line
		xyPosition,   						; coordinates of first char
		ADDR count    						; output count
	
	; 改變游標位置
	push dx
	mov  dl, 36
	mov  dh, 22
	call Gotoxy
	pop  dx
	
    call WaitMsg
    call Clrscr
	
	mov xyPosition.x, 1
	mov xyPosition.y, 1
; ----------------------Page2------------------------------------------------------	
P2_name:

	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule1,   						
		sizeof rule1,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	inc xyPosition.y
	
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule2,   						
		sizeof rule2,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule3,   						
		sizeof rule3,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	
	
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule4,   						
		sizeof rule4,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	inc xyPosition.y
	
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule5,   						
		sizeof rule5,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule6,   						
		sizeof rule6,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule7,   						
		sizeof rule7,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule8,   						
		sizeof rule8,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule9,   						
		sizeof rule9,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr rule10,   						
		sizeof rule10,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	inc xyPosition.y
	inc xyPosition.y
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		addr age,   						
		sizeof age,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y

		
		
		push dx
		mov  dl, 1
		mov  dh, 19
		call Gotoxy
		pop  dx
		
		call ReadInt
		mov age0, eax
; 判斷是否超過18
		.IF eax < 18
			call Clrscr
			jmp no18
		.ENDIF		
		call Clrscr
		jmp firstPlay
; 未滿18		
no18:	
	mov xyPosition.x, 27
	mov xyPosition.y, 3
	INVOKE print_stop, addr stop1, xyPosition
	INVOKE print_stop, addr stop2, xyPosition
	INVOKE print_stop, addr stop3, xyPosition
	INVOKE print_stop, addr stop4, xyPosition
	INVOKE print_stop, addr stop5, xyPosition
	INVOKE print_stop, addr stop6, xyPosition
	INVOKE print_stop, addr stop7, xyPosition
	INVOKE print_stop, addr stop8, xyPosition
	INVOKE print_stop, addr stop9, xyPosition
	INVOKE print_stop, addr stop10, xyPosition
	INVOKE print_stop, addr stop11, xyPosition
	INVOKE print_stop, addr stop12, xyPosition
	INVOKE print_stop, addr stop13, xyPosition
	INVOKE print_stop, addr stop14, xyPosition
	INVOKE print_stop, addr stop15, xyPosition
	INVOKE print_stop, addr stop16, xyPosition
	INVOKE print_stop, addr stop17, xyPosition
	INVOKE print_stop, addr stop18, xyPosition
	INVOKE print_stop, addr stop19, xyPosition
	INVOKE print_stop, addr stop20, xyPosition
	INVOKE print_stop, addr stop21, xyPosition
	INVOKE print_stop, addr stop22, xyPosition
	mov xyPosition.x, 37
	mov xyPosition.y, 26
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   				
		ADDR adult_only,   						
		sizeof adult_only,   						
		xyPosition,   					
		ADDR count
	jmp END_END
	call Clrscr
; ------------------------------------Top----------------------------------------
firstPlay:
	mov esi, 500d
play:
	invoke topBar , esi , 0
	
	; 改變游標位置
	push dx
	mov  dl, 15
	mov  dh, 1
	call Gotoxy
	pop  dx
; -----------------------------game icon-----------------------------------------------
	
	mov xyPosition.x, 7
	mov xyPosition.y, 7	
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		ADDR top_bar,   						
		sizeof top_bar,   						
		xyPosition,   						
		ADDR count
	inc xyPosition.y
	
	mov ecx, 9
BODY1:	
	push ecx
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		ADDR bodybar,   						
		sizeof bodybar,   						
		xyPosition,   						
		ADDR count
	pop ecx
	inc xyPosition.y
	loop BODY1

INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		ADDR top_bar,   						
		sizeof top_bar,   						
		xyPosition,   						
		ADDR count	
	
	mov xyPosition.x, 8
	mov xyPosition.y, 9
twenty1:	
	INVOKE printstr, addr BJ1, xyposition
	INVOKE printstr, addr BJ2, xyposition
	INVOKE printstr, addr BJ3, xyposition
	INVOKE printstr, addr BJ4, xyposition
	INVOKE printstr, addr BJ5, xyposition
	INVOKE printstr, addr BJ6, xyposition
	INVOKE printstr, addr BJ7, xyposition

	mov xyPosition.x, 30
	mov xyPosition.y, 9
tenthirty:
	INVOKE printstr, addr tenthirty1, xyPosition
	INVOKE printstr, addr tenthirty2, xyPosition
	INVOKE printstr, addr tenthirty3, xyPosition
	INVOKE printstr, addr tenthirty4, xyPosition
	INVOKE printstr, addr tenthirty5, xyPosition
	INVOKE printstr, addr tenthirty6, xyPosition
	INVOKE printstr, addr tenthirty7, xyPosition
	
	mov xyPosition.x, 52
	mov xyPosition.y, 9
slotm:
	INVOKE printstr, addr sl1, xyPosition
	INVOKE printstr, addr sl2, xyPosition
	INVOKE printstr, addr sl3, xyPosition
	INVOKE printstr, addr sl4, xyPosition
	INVOKE printstr, addr sl5, xyPosition
	INVOKE printstr, addr sl6, xyPosition
	INVOKE printstr, addr sl7, xyPosition
	
	mov xyPosition.x, 75
	mov xyPosition.y, 9
bigsmall:
	INVOKE printstr, addr BG1, xyPosition
	INVOKE printstr, addr BG2, xyPosition
	INVOKE printstr, addr BG3, xyPosition
	INVOKE printstr, addr BG4, xyPosition
	INVOKE printstr, addr BG5, xyPosition
	INVOKE printstr, addr BG6, xyPosition
	INVOKE printstr, addr BG7, xyPosition
; ------------------------------Read view----------------------------------------------
RBJ:	
	mov xyPosition.x, 8
	mov xyPosition.y, 19
	INVOKE print_R, addr pick_BJ, xyPosition
	INVOKE print_R, addr tenStr, xyPosition
	INVOKE print_R, addr slot, xyPosition
	INVOKE print_R, addr big, xyPosition
	mov xyPosition.x, 8
	jmp read
Rten:
	mov xyPosition.x, 8
	INVOKE print_R, addr BJ, xyPosition
	INVOKE print_R, addr pick_ten, xyPosition
	INVOKE print_R, addr slot, xyPosition
	INVOKE print_R, addr big, xyPosition
	mov xyPosition.x, 30
	jmp read
Rslot:
	mov xyPosition.x, 8
	INVOKE print_R, addr BJ, xyPosition
	INVOKE print_R, addr tenStr, xyPosition
	INVOKE print_R, addr pick_slot, xyPosition
	INVOKE print_R, addr big, xyPosition
	mov xyPosition.x, 52
	jmp read
Rbig:
	mov xyPosition.x, 8
	INVOKE print_R, addr BJ, xyPosition
	INVOKE print_R, addr tenStr, xyPosition
	INVOKE print_R, addr slot, xyPosition
	INVOKE print_R, addr pick_big, xyPosition
	mov xyPosition.x, 74
; --------------------------------- listen key---------------------------------
read:
	mov xyPosition.y, 19
	xor eax, eax
	call ReadChar
	.IF ax == 1C0Dh					;enter
		jmp pick
	.ENDIF
	.IF ax == 2064h					;right(d)
		add xyPosition.x, 22
	.ENDIF	
	.IF ax == 1E61h                 ;LEFT(a)
		sub xyPosition.x, 22
	.ENDIF	
	.IF ax == 011Bh                 ;LEFT(a)
		jmp END_END
	.ENDIF	
	
	.IF xyPosition.x == 8
		jmp RBJ
	.ENDIF	
	.IF xyPosition.x == 30
		jmp Rten
	.ENDIF
	.IF xyPosition.x == 52
		jmp Rslot
	.ENDIF
	.IF xyPosition.x == 74
		jmp Rbig
	.ENDIF
	.IF xyPosition.x < 8
		jmp RBJ
	.ENDIF
	.IF xyPosition.x > 74
		jmp Rbig
	.ENDIF
	jmp read

pick:
	.IF xyPosition.x == 8
		call twentyOne
	.ELSEIF xyPosition.x == 30
		call ten
	.ELSEIF xyPosition.x == 52
		call sm
	.ELSEIF xyPosition.x == 74
		call bs2
	.ENDIF
	call Clrscr
	
	; 從遊戲出來時
	.IF esi > 0
		jmp play
	.ELSEIF esi <= 0
		call loser
		invoke sleep, 1500
	.ENDIF
	
END_END:
	INVOKE sleep, 800
END_PICK:				
	INVOKE sleep, 500
	call Clrscr
	

exit	

start@0 ENDP
END start@0
 
