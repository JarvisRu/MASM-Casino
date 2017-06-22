TITLE slot_machine (slot_machine.asm)

INCLUDE mylib.inc

SlotWidth = 4
SlotHeight = 3
BarWidth = 2
BarHeight = 3
MachineWidth = 10
SameWidth = 1
betMoneyStrWidth = 4

WinWidth = 9
LoseWidth = 10

WriteConsoleOutputCharacter PROTO,
	handleScreenBuf:DWORD,			; console output handle
	pBuffer:PTR BYTE,				; pointer to buffer
	bufsize:DWORD,					; size of buffer
	xyPos:COORD,					; first cell coordinates
	pCount:PTR DWORD					; output count
	
Sleep PROTO,
dwMilliseconds:DWORD

.data 
;SlotTop    BYTE 0DBh, 0DBh, 0DBh
;SlotBody   BYTE 0DBh, 0DBh, 0DBh
;SlotBottom BYTE 0DBh, 0DBh, 0DBh

Machine1   BYTE "+--------+"
Machine2   BYTE "| CASINO |"
Machine3   BYTE "|        |"
Machine4   BYTE "|>      <|"
Machine5   BYTE "|    [_] |"

SlotTop    BYTE '0', '0', '0', '0'
SlotBody   BYTE '0', '0', '0', '0'
SlotBottom BYTE '0', '0', '0', '0'

BarTop1	   BYTE ' ', 'o'
BarTop2    BYTE ' ', '|'
BarBody    BYTE '/', ' '
BarBottom1 BYTE ' ', ' '
BarFinal   BYTE ' ', ' '

Win		   BYTE "You Get $"
Lose	   BYTE "You Lost $"


Same BYTE '0'

position COORD <34,9>

attributes WORD SlotWidth DUP(0Ah)

.code

sm PROC

call Clrscr

Start:
INVOKE topBar, esi , 3
INVOKE GetStdHandle, STD_OUTPUT_HANDLE  ; Get the console ouput handle
    mov outputHandle, eax 				; save console handle
	
	mov position.x, 43
	mov position.y, 9
; Draw the slot machine
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine1,   					
    MachineWidth,   					
    position,   						
    ADDR count
	
	inc position.y
	
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine2,   					
    MachineWidth,   					
    position,   						
    ADDR count
	
	inc position.y
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine1,   					
    MachineWidth,   					
    position,   						
    ADDR count
	
	inc position.y
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine3,   					
    MachineWidth,   					
    position,   						
    ADDR count
	
	inc position.y
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine4,   					
    MachineWidth,   					
    position,   						
    ADDR count
	
	inc position.y
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine3,   					
    MachineWidth,   					
    position,   						
    ADDR count
	
	inc position.y
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine1,   					
    MachineWidth,   					
    position,   						
    ADDR count
	
	inc position.y
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine5,   					
    MachineWidth,   					
    position,   						
    ADDR count
	
	inc position.y
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					
    ADDR Machine1,   					
    MachineWidth,   					
    position,   						
    ADDR count
	

; Draw first raw of slot
	mov position.x, 46
	mov position.y, 12
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR SlotTop,   						; pointer to the top Slot line
    SlotWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count    						; output count

    inc position.y   					; 座標換到下一行位置
    ;mov ecx, (SlotHeight-2)   			; number of lines in body

; Draw second raw of slot
L1:
	;push ecx  							; save counter 避免invoke 有使用到這個暫存器
  
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR SlotBody,   						; pointer to the top Slot line
    SlotWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count    						; output count
 
    inc position.y   					; next line
    ;pop ecx   							; restore counter
    ;loop L1

; Draw third raw of slot

INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR SlotBottom,   					; pointer to the top Slot line
    SlotWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count			   				; output count 
	
	mov position.x, 53
	mov position.y, 11
	
	mov BarTop1[0], ' '
	mov BarTop1[1], 'o'
	mov BarTop2[0], ' '
	mov BarTop2[1], '|'
	mov BarBody[0], '/'
	mov BarBody[1], ' '
	mov BarBottom1[0], ' '
	mov BarBottom1[1], ' '
	mov BarFinal[0], ' '
	mov BarFinal[1], ' '

; Draw first raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarTop1,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count
	
	inc position.y 

; Draw second raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarTop2,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count    						; output count
 
    inc position.y   					; next line
    ;pop ecx   							; restore counter
    ;loop L1

; Draw third raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarBody,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count			   				; output count 
	
INVOKE showStatus, 1				; show input betMoneyStr

	; 若賭金>本金
	.IF esi < eax
		add statusPosition.y , 2
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR noMoney, 
		  SIZEOF noMoney,        
		  statusPosition,      
		  ADDR cellsWritten 
		sub statusPosition.y , 2
		
		INVOKE sleep , 1000
		call Clrscr
		jmp Start
		
	; 若賭金=0
	.ELSEIF eax == 0
		add statusPosition.y , 2
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR zeroMoney, 
		  SIZEOF zeroMoney,        
		  statusPosition,      
		  ADDR cellsWritten 
		sub statusPosition.y , 2
		
		INVOKE sleep , 1000
		call Clrscr
		jmp Start
	.ENDIF
	
	push eax
	
INVOKE Sleep, 200						; delay
	
	mov BarTop1[1], ' '
	mov BarTop2[1], '0'
	
	mov position.y, 11
	; Draw first raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarTop1,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count
	
	inc position.y 

; Draw second raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarTop2,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count    						; output count
 
    inc position.y   					; next line
    ;pop ecx   							; restore counter
    ;loop L1

; Draw third raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarBody,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count			   				; output count 
	
INVOKE Sleep, 200						; delay
	
	mov BarTop2[1],	' '
	mov BarBody[0], '-'
	mov BarBody[1], 'O'
	
	mov position.y, 11
	; Draw first raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarTop1,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count
	
	inc position.y 

; Draw second raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarTop2,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count    						; output count
 
    inc position.y   					; next line
    ;pop ecx   							; restore counter
    ;loop L1

; Draw third raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarBody,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count			   				; output count 
	
	INVOKE Sleep, 200					; delay
	
	mov BarBody[0], '\'
	mov BarBody[1], ' '
	mov BarBottom1[1], '0'
	
	mov position.y, 13
	
; Draw third raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarBody,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count
	
	inc position.y 

; Draw forth raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarBottom1,   					; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count    						; output count
 
    inc position.y   					; next line
    ;pop ecx   							; restore counter
    ;loop L1

; Draw fifth raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarFinal,   					; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count			   				; output count 
	
	INVOKE Sleep, 200					; delay
	
	mov BarBottom1[1], '|'
	mov BarFinal[1], 'o'
	
	mov position.y, 13
	; Draw third raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarBody,   						; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count
	
	inc position.y 

; Draw forth raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarBottom1,   					; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count    						; output count
 
    inc position.y   					; next line
    ;pop ecx   							; restore counter
    ;loop L1

; Draw fifth raw of bar
INVOKE WriteConsoleOutputCharacter,
    outputHandle,   					; console output handle
    ADDR BarFinal,   					; pointer to the top Slot line
    BarWidth,   						; size of Slot line
    position,   						; coordinates of first char
    ADDR count			   				; output count 
	
	call Randomize						; reset random seed
	mov ebx, 6
LRun:
		mov ecx, 4
	LRanTop:								; random the first raw
		mov eax, 7
		call RandomRange					; get random number (0~7)
		add eax, 30h						; 1 -> '1'
		push ecx
		sub ecx, 4
		neg ecx
		mov SlotTop[ecx], al
		pop ecx
		loop LRanTop

		mov ecx, 4
	LRanBody:								; random the second raw
		mov eax, 7
		call RandomRange					; get random number (0~7)
		add eax, 30h						; 1 -> '1'
		push ecx
		sub ecx, 4
		neg ecx
		mov SlotBody[ecx], al
		pop ecx
		loop LRanBody
		
		mov ecx, 4
	LRanBottom:								; random the third raw
		mov eax, 7
		call RandomRange					; get random number (0~7)
		add eax, 30h						; 1 -> '1'
		push ecx
		sub ecx, 4
		neg ecx
		mov SlotBottom[ecx], al
		pop ecx
		loop LRanBottom
		
		mov position.x, 46
		mov position.y, 12
		
		cmp ebx, 3
		ja LFast0
		jna LSlow0
		
	LFast0:
		INVOKE Sleep, 100
		jmp Lcon0
	LSlow0:
		INVOKE Sleep, 200

;LCheat:
;	mov SlotBody[0], '1'
;	mov SlotBody[1], '1'	
;	mov SlotBody[2], '1'	
;	mov SlotBody[3], '1'	
	
	Lcon0:
		; Draw first raw of slot
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; console output handle
		ADDR SlotTop,   						; pointer to the top Slot line
		SlotWidth,   						; size of Slot line
		position,   						; coordinates of first char
		ADDR count    						; output count
		
		inc position.y
		cmp ebx, 3
		ja LFast1
		jna LSlow1
		
	LFast1:
		INVOKE Sleep, 100
		jmp Lcon1
	LSlow1:
		INVOKE Sleep, 200
		
	Lcon1:	
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; console output handle
		ADDR SlotBody,   					; pointer to the top Slot line
		SlotWidth,   						; size of Slot line
		position,   						; coordinates of first char
		ADDR count    						; output count
		
		inc position.y
		cmp ebx, 3
		ja LFast2
		jna LSlow2
		
	LFast2:
		INVOKE Sleep, 100
		jmp Lcon2
	LSlow2:
		INVOKE Sleep, 200
		
	Lcon2:
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; console output handle
		ADDR SlotBottom,   					; pointer to the top Slot line
		SlotWidth,   						; size of Slot line
		position,   						; coordinates of first char
		ADDR count    						; output count

		dec ebx
		cmp ebx, 0
	jne LRun
	
	
; Find how many same number in SlotBody
	mov bh, 0
	mov bl, 0
	mov bl, SlotBody[0]
	mov ecx, 3
LCompare0:								; if SlotBody[0] == [1], [2], [3]
	.IF SlotBody[ecx] == bl
	inc bh
	.ENDIF
	loop LCompare0

	mov bl, SlotBody[1]
	mov ecx, 2
LCompare1:								; if SlotBody[1] == [2], [3]
	push ecx
	inc ecx
	.IF SlotBody[ecx] == bl
	inc bh
	.ENDIF
	pop ecx
	loop LCompare1
	
	mov bl, SlotBody[2]					; if SlotBody[2] == [3]
	.IF SlotBody[3] == bl
	inc bh
	.ENDIF

; betbetMoneyStr = 10, 50, 100, 500

	pop eax
	
	.IF bh == 0							; 1234
		jmp LLose						; lose all betMoneyStr
	.ENDIF
	
	.IF bh == 1							; 1134
		mov bl, 10
		div bl							
		movzx eax, al					; win 0.1*bet
		jmp LWin
	.ENDIF
	
	.IF bh == 2							; 1133
		jmp LWin						; win 1*bet
	.ENDIF
	
	.IF bh == 3							; 1114
		push eax
		mov bl, 2
		div bl
		movzx ebx, al
		pop eax
		add eax, ebx					; win 1.5*bet
		jmp LWin
	.ENDIF
	
	.IF bh == 6							; 1111
		add eax, eax
		add eax, eax					; win 4*bet
		jmp LWin
	.ENDIF
		
LLose:
	sub esi, eax
	mov bl, 10
	mov edi, 3
	
LtoStr:
	div bl
	add ah, 30h					; 1 -> '1'
	mov betMoneyStr[edi], ah
	
	dec edi
	movzx ax, al
	cmp al, 0
	ja LtoStr
	
	mov edi, 0
	
	; You lose~ Lose $ ...
	mov position.x, 21
	mov position.y, 22
	
	INVOKE showStatus, 4
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,				
    ADDR betMoneyStr,   					
    betMoneyStrWidth,   					
    position,   						
    ADDR count

	jmp again1
	
LWin:
	add esi, eax
	mov bl, 10
	mov edi, 4
LtoStr1:
	div bl
	add ah, 30h					; 1 -> '1'
	push edi
	dec edi
	mov betMoneyStr[edi], ah
	
	pop edi
	movzx ax, al
	dec edi
	cmp al, 0
	ja LtoStr1

	; You win! Win $ ...
	mov position.x, 18
	mov position.y, 22
	
	INVOKE showStatus, 3
	
	INVOKE WriteConsoleOutputCharacter,
    outputHandle,				
    ADDR betMoneyStr,   					
    betMoneyStrWidth,   					
    position,   						
    ADDR count
	
	
	; YES
again1: 
	
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR againStr1, 
      SIZEOF againStr1,        
      againPosition,      
      ADDR cellsWritten
	jmp read2
; NO
again2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR againStr2, 
      SIZEOF againStr2,        
      againPosition,      
      ADDR cellsWritten
	jmp read2
	
read2:
	xor eax, eax
	call ReadChar
	.IF ax == 1C0Dh					;enter
		jmp choose
	.ENDIF
	.IF ax == 2064h					;right(d)
		add againStatus, 1
	.ENDIF	
	.IF ax == 1E61h                 ;LEFT(a)
		sub againStatus, 1
	.ENDIF	
	
	.IF againStatus == 1
		jmp again1
	.ENDIF	
	.IF againStatus == 2
		jmp again2
	.ENDIF
	.IF againStatus < 1
		mov againStatus, 1
		jmp again1
	.ENDIF
	.IF againStatus > 2
		mov againStatus, 2
		jmp again2
	.ENDIF
	jmp read2

choose:
	.IF againStatus == 1
		jmp initial
	.ELSE
		jmp Lexit			; 目前先寫直接結束就好 之後再改
	.ENDIF
	
;初始化自己的data
initial:
	mov SlotTop[0], '0'
	mov SlotTop[1], '0'
	mov SlotTop[2], '0'
	mov SlotTop[3], '0'
	
	mov SlotBody[0], '0'
	mov SlotBody[1], '0'
	mov SlotBody[2], '0'
	mov SlotBody[3], '0'
	
	mov SlotBottom[0], '0'
	mov SlotBottom[1], '0'
	mov SlotBottom[2], '0'
	mov SlotBottom[3], '0'
	
	mov BarTop1[0], ' '
	mov BarTop1[1], 'o'
	mov BarTop2[0], ' '
	mov BarTop2[1], '|'
	mov BarBody[0], '/'
	mov BarBody[1], ' '
	mov BarBottom1[0], ' '
	mov BarBottom1[1], ' '
	mov BarFinal[0], ' '
	mov BarFinal[1], ' '
	
	mov eax, 0
	mov betMoneyStr[0], 0
	mov betMoneyStr[1], 0
	mov betMoneyStr[2], 0
	mov betMoneyStr[3], 0
	
	mov againStatus, 1	; 這個大家都要留
	
	call Clrscr
	jmp Start	; 自己遊戲的開始 invoke showStatus,1 的地方
	
Lexit:	
    call Clrscr
    ret
	
sm ENDP

END
 
