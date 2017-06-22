INCLUDE mylib.inc
main	EQU start@0

.data

.code

topBar PROC USES esi ecx edi , allMoney : DWORD , status:byte

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE  
    mov outputHandle, eax
	

P3_choose_game:
	mov xyPosition.x,0
	mov xyPosition.y,0
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					
		ADDR bar1,   						
		sizeof bar1,   						
		xyPosition,   						
		ADDR count    						
	call crlf
	inc xyPosition.y

	mov ecx, 4
L1:
	push ecx
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; body1
		ADDR bar2,   						
		sizeof bar2,   						
		xyPosition,   						
		ADDR count    						
	call crlf
	inc xyPosition.y
	pop ecx
	loop L1
	
	mov ecx, 4
	mov xyPosition.x, 99
	mov xyPosition.y, 1
L3:
	push ecx
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; body2
		ADDR bar2,   						
		sizeof bar2,   						
		xyPosition,   						
		ADDR count    						
	call crlf
	inc xyPosition.y
	pop ecx
	loop L3
	
	mov xyPosition.x, 3
	mov xyPosition.y, 1
	.IF status == 0
		INVOKE WriteConsoleOutputCharacter,
			outputHandle,   					; now playing
			ADDR now_playing,   					
			sizeof now_playing,   				
			xyPosition,   						
			ADDR count 
	.ELSEIF status == 1
		INVOKE WriteConsoleOutputCharacter,
			outputHandle,   					; now playing
			ADDR now_playing1,   					
			sizeof now_playing1,   				
			xyPosition,   						
			ADDR count
	.ELSEIF status == 2
		INVOKE WriteConsoleOutputCharacter,
			outputHandle,   					; now playing
			ADDR now_playing2,   					
			sizeof now_playing2,   				
			xyPosition,   						
			ADDR count
	.ELSEIF status == 3
		INVOKE WriteConsoleOutputCharacter,
			outputHandle,   					; now playing
			ADDR now_playing3,   					
			sizeof now_playing3,   				
			xyPosition,   						
			ADDR count
	.ELSEIF status == 4
		INVOKE WriteConsoleOutputCharacter,
			outputHandle,   					; now playing
			ADDR now_playing4,   					
			sizeof now_playing4,   				
			xyPosition,   						
			ADDR count
	.ENDIF
	inc xyPosition.y
	inc xyPosition.y
	
	mov eax, allMoney						; change money(binary) to string
	mov bl, 10
	mov edi, 4
L2:											
	div bl
	add ah, 30h
	mov moneystr[edi], ah
	dec edi
	movzx ax, al
	cmp al, 0
	ja L2
	
	
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; indicate money
		ADDR moneystr,   					
		sizeof moneystr,   					
		xyPosition,   						
		ADDR count    						
	inc xyPosition.y
						

	mov xyPosition.x, 0	
	add xyPosition.y, 1
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; bottom
		ADDR bar3,   						
		sizeof bar3,   						
		xyPosition,   						
		ADDR count    						
	call crlf
	
	mov moneystr[1],0 
	mov moneystr[2],0
	mov moneystr[3],0
	mov moneystr[4],0
	ret
topBar ENDP
END