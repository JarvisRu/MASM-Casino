INCLUDE mylib.inc

main	EQU start@0

;H = 愛心  D = 菱形   C = 梅花   S = 黑桃  R = 右上   L = 左下
;ex: CardHR1 = 右上位置的愛心1, CardSLJ = 左下位置的黑桃J

.data
dealer DWORD 100 DUP(?)
dealerSuit DWORD 100 DUP(?)
dealerSum DWORD ?
dealerSumStr BYTE 2 DUP(?)
dealerStr BYTE "Dealer:"
dealerStrPosition	COORD	<42, 8>

PlayerSuit DWORD ?
PlayerSum DWORD ?
PlayerSumStr BYTE 2 DUP(?)
PlayerStr BYTE "Player:"
PlayerStrPosition	COORD	<2,8>

number DWORD ?
counter DWORD ?
counter1 DWORD ?
selection1		BYTE  "[ Yes ]      No  ",0
selection2		BYTE  "  Yes      [ No ]",0
selectionPosition	COORD		<3,19>
selectionStatus BYTE  1



.code
twentyOne PROC USES ebx edx ecx edi
	call Randomize
Start:
	; 初始化
	mov ebx, 0
	mov edx, 0
	mov ecx, 5
	mov edi, 0
	
	mov dealerSum, 0
	mov PlayerSum, 0
	
	mov counter, 0
	mov counter1, 0
	
	mov playerPosition.x, 2
	mov playerPosition.y, 10
	mov PlayerStrPosition.x, 2
	mov PlayerStrPosition.y, 8
	
	mov dealerPosition.x, 42
	mov dealerPosition.y, 10
	mov dealerStrPosition.x, 42
	mov dealerStrPosition.y, 8
	
	mov selectionPosition.x, 3
	mov selectionPosition.y, 19
	
	mov selectionStatus, 1
	
	mov betMoneyStr[0],0
	mov betMoneyStr[1],0
	mov betMoneyStr[2],0
	mov betMoneyStr[3],0
	
	mov dealerSumStr[0],0
	mov dealerSumStr[1],0
	
	mov PlayerSumStr[0],0
	mov PlayerSumStr[1],0
	
	call Clrscr
	
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
;-----------------------------------------------
	; show top列	
	invoke topBar , esi , 1
	; show 狀態列
	push eax
	invoke showStatus, 1
	mov	   betMoney,eax
	
	; 若賭金>本金
	 .IF esi < eax
		mov statusPosition.x , 0
		mov statusPosition.y , 23
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR noMoney, 
		  SIZEOF noMoney,        
		  statusPosition,      
		  ADDR cellsWritten 
		mov statusPosition.x , 0
		mov statusPosition.y , 21
		
		INVOKE sleep , 1000
		call Clrscr
		pop eax
		jmp Start
	; 若賭金=0
	.ELSEIF eax == 0
		mov statusPosition.x , 0
		mov statusPosition.y , 23
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR zeroMoney, 
		  SIZEOF zeroMoney,        
		  statusPosition,      
		  ADDR cellsWritten 
		mov statusPosition.x , 0
		mov statusPosition.y , 21
		
		pop eax
		INVOKE sleep , 1000
		call Clrscr
		jmp Start
	 .ENDIF
	pop eax
	
;印出Player:  和  Dealer:-----------------------------------	
	
	INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR PlayerStr, 
		  SIZEOF PlayerStr,        
		  PlayerStrPosition,      
		  ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR dealerStr, 
		  SIZEOF dealerStr,        
		  dealerStrPosition,      
		  ADDR cellsWritten
		  
;亂數產生莊家的牌--------------------------------------------	
	
dealerRandom:
	.if  dealerSum >= 16
		jmp	 PlayerRandom
	.elseif counter >=5
		jmp  PrintFirstDealer
	.endif
	mov  eax, 13
	call RandomRange
	mov  number, eax
	.if  eax == 0
	mov  number, 13
	.endif
	inc  eax
	.if  eax > 10
		mov eax, 10
	.endif
	mov  dealer[edi], eax
	add  dealerSum, eax
	mov  eax, 4
	call RandomRange
	inc  eax
	mov  dealerSuit[edi], eax
	.IF  counter == 0
		INVOKE printBackCard, dealerPosition
	.ELSE
		INVOKE printCard, dealerSuit[edi], number, dealerPosition
	.ENDIF
	add dealerPosition.x, 8   ;設定下一張撲克牌要印出的X座標
	add edi, 4
	inc  counter

;亂數產生玩家牌之前的判斷------------------------	
	
PlayerRandom:
	.if  PlayerSum >= 11
		.if PlayerSum <= 21
			jmp  select1 
		.endif
	.endif
	.if  PlayerSum > 21
		jmp  PrintFirstDealer 
	.endif
	
;亂數產生玩家的牌---------------------------------
	
PlayerRandom1:
	mov  eax, 13
	call RandomRange
	mov  number, eax
	.if  eax == 0
		mov  number, 13
	.endif
	inc  eax
	.if  eax > 10
		mov eax, 10
	.endif
	add  PlayerSum, eax
	mov  eax, 4
	call RandomRange
	inc  eax
	mov  PlayerSuit, eax
	INVOKE printCard, PlayerSuit, number, playerPosition
	add playerPosition.x, 8d   ;設定下一張撲克牌要印出的X座標
	inc counter1
	.if counter1 >= 5
		jmp PrintFirstDealer
	.endif
	jmp  dealerRandom
	
;印出莊家第一張牌-------------------------------

PrintFirstDealer:
	push eax
	INVOKE sleep, 500
	mov  edi, 0
	dec  dealer[edi]
	.if  dealer[edi] == 0
		mov  dealer[edi], 13
	.endif
	mov  dealerPosition.x, 42
	mov  dealerPosition.y, 10
	INVOKE printCard, dealerSuit[edi], dealer[edi], dealerPosition
	pop eax

;輸出玩家和莊家的點數總和------------------------------------	
	
PrintSum:
Sum:
	
	push eax
	push bx
	push edi
	
	mov eax, PlayerSum       
	mov bl, 10
	mov edi, 1
InttoStr:           
	div bl
	add ah, 30h
	mov PlayerSumStr[edi], ah
	dec edi
	movzx ax, al
	cmp al, 0
	ja InttoStr
	
	pop edi
	pop bx
	pop eax
	
	add PlayerStrPosition.x, 8
	
	INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR PlayerSumStr, 
		  SIZEOF PlayerSumStr,        
		  PlayerStrPosition,      
		  ADDR cellsWritten
Sum1:
	
	push eax
	push bx
	push edi
	
	mov eax, dealerSum       
	mov bl, 10
	mov edi, 1
InttoStr1:           
	div bl
	add ah, 30h
	mov dealerSumStr[edi], ah
	dec edi
	movzx ax, al
	cmp al, 0
	ja InttoStr1
	
	pop edi
	pop bx
	pop eax
	
	add dealerStrPosition.x, 8
	
	INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR dealerSumStr, 
		  SIZEOF dealerSumStr,        
		  dealerStrPosition,      
		  ADDR cellsWritten
	
;比較輸贏-----------------------------------------	
	
Compare:
	push eax
	mov  eax, dealerSum
	.if dealerSum > 21
		.if PlayerSum > 21
			jmp  tie
		.ELSEIF PlayerSum <= 21
			jmp  win
		.ENDIF
	.ELSEIF PlayerSum > 21
		.if dealerSum > 21
			jmp  tie
		.ELSEIF dealerSum <= 21
			jmp  lose
		.ENDIF
	.ENDIF
	.if counter >= 5
		.if counter1 < 5
			jmp lose
		.endif
	.elseif counter1 >= 5
		.if counter < 5
			jmp win
		.endif
	.endif
	cmp  PlayerSum, eax
	ja	 win
	jb	 lose
	je	 tie
	pop  eax
	
win:
	INVOKE showstatus, 3
	; 加進總金額
	mov ebx, betMoney
	add esi, ebx
	
	pop eax
	jmp num2Str
	
lose:
	INVOKE showStatus, 4
	; 輸的錢扣在總金額
	mov ebx, betMoney
	sub esi, ebx
	
	pop eax
	jmp num2Str
	
tie:
	INVOKE showstatus, 2
	
	pop eax
	jmp ifNoMoney
	
; -----------------------------------------------------------------
num2Str:
	
	push eax
	push bx
	push edi
	
	mov eax, betMoney       
	mov bl, 10
	mov edi, 3
toStr:           
	div bl
	add ah, 30h
	mov betMoneyStr[edi], ah
	dec edi
	movzx ax, al
	cmp al, 0
	ja toStr
	
	pop edi
	pop bx
	pop eax
	
	mov statusPosition.x, 20
	mov statusPosition.y, 22
	
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR betMoneyStr, 
      SIZEOF betMoneyStr,        
      statusPosition,      
      ADDR cellsWritten
	jmp ifNoMoney
	
; 判斷是否破產
ifNoMoney:
	.IF esi <= 0
		INVOKE sleep, 500
		jmp bye
	.ENDIF
	jmp Again1
	
; 問是否要牌-----------------------------------------------
	
select1:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR selection1, 
      SIZEOF selection1,        
      selectionPosition,      
      ADDR cellsWritten

	jmp read

select2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR selection2, 
      SIZEOF selection2,        
      selectionPosition,      
      ADDR cellsWritten

	jmp read

read:
	xor eax, eax
	call ReadChar
	.IF ax == 1C0Dh					;enter
		.IF selectionStatus == 1
				jmp PlayerRandom1
		.ELSE
			.IF dealerSum >= 16
				jmp PrintFirstDealer
			.ELSEIF dealerSum < 16
				jmp dealerRandom
			.ENDIF
		.ENDIF
	.ENDIF
	.IF ax == 2064h					;right(d)
		add selectionStatus, 1
	.ENDIF	
	.IF ax == 1E61h                 ;LEFT(a)
		sub selectionStatus, 1
	.ENDIF	
	
	.IF selectionStatus == 1
		jmp select1
	.ENDIF	
	.IF selectionStatus == 2
		jmp select2
	.ENDIF
	.IF selectionStatus < 1
		mov selectionStatus, 1
		jmp select1
	.ENDIF
	.IF selectionStatus > 2
		mov selectionStatus, 2
		jmp select2
	.ENDIF
	jmp read

; 問是否繼續-----------------------------------------------

Again1:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR againStr1, 
      SIZEOF againStr1,        
      againPosition,      
      ADDR cellsWritten
	jmp read1
Again2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR againStr2, 
      SIZEOF againStr2,        
      againPosition,      
      ADDR cellsWritten
	jmp read1
	
read1:
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
		jmp Again1
	.ENDIF	
	.IF againStatus == 2
		jmp Again2
	.ENDIF
	.IF againStatus < 1
		mov againStatus, 1
		jmp Again1
	.ENDIF
	.IF againStatus > 2
		mov againStatus, 2
		jmp Again2
	.ENDIF
	jmp read1
	
choose:
	.IF againStatus == 1
		mov againStatus, 1
		jmp Start
	.ELSE
		mov againStatus, 1
		jmp bye
	.ENDIF
	

bye:	
	mov dealerSum, 0
	mov PlayerSum, 0
	
	mov counter, 0
	mov counter1, 0
	
	mov playerPosition.x, 2
	mov playerPosition.y, 10
	
	mov dealerPosition.x, 42
	mov dealerPosition.y, 10
	
	mov selectionPosition.x, 3
	mov selectionPosition.y, 19
	
	mov selectionStatus, 1
	
	mov betMoneyStr[0],0
	mov betMoneyStr[1],0
	mov betMoneyStr[2],0
	mov betMoneyStr[3],0
	
	mov dealerSumStr[0],0
	mov dealerSumStr[1],0
	
	mov PlayerSumStr[0],0
	mov PlayerSumStr[1],0
	
    call Clrscr
    ret

twentyOne ENDP
END