INCLUDE mylib.inc
main	EQU start@0

CardWidth = 7
CardHeight = 4
.data

;-------------------game----------------------
chooseCardStr   BYTE  "Please Choose One Card",0
roleStr			BYTE  "Player:                                   Dealer:",0
selection1		BYTE  "[ 1 ]         2           3  ",0
selection2		BYTE  "  1         [ 2 ]         3  ",0
selection3		BYTE  "  1           2         [ 3 ]",0
selectionStatus	BYTE  1
; COORD
selectionPosition 	COORD    <3,19>
pleasePosition		COORD	 <0,7>

; player
playerSuit		DWORD 3 DUP(?)
playerNumber 	DWORD 3 DUP(?)

; dealer
 dealerSuit		DWORD ?
 dealerNumber 	DWORD ?


.code
bs2 PROC  USES ebx
    ; Get the console ouput handle
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
	call Clrscr
    ; set screen title and size
    INVOKE SetConsoleTitle, ADDR titleStr
    INVOKE SetConsoleScreenBufferSize, outputHandle, screen_size
	; ------------------------------------------------------------------
Start:
	; show top列	
	invoke topBar , esi , 4
	; show 狀態列
	invoke showStatus, 1
	mov	   betMoney,eax
	
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
		
		INVOKE sleep , 5000
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
	
; 遊戲區------------------------------------------------------------------
	
	; 印出 "Please choose one card"
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR chooseCardStr, 
      SIZEOF chooseCardStr,        
      pleasePosition,      
      ADDR cellsWritten 
	add pleasePosition.y , 2
	
	; 印出 role 
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR roleStr, 
      SIZEOF roleStr,        
      pleasePosition,      
      ADDR cellsWritten 
	  
	; 印出玩家牌
	push ecx 
	push esi
	mov esi,0
	mov ecx, 3
	call Randomize
PlayerRandom:
	
	mov  eax, 13
	call RandomRange
	inc  eax
	mov  playerNumber[esi], eax
	
	mov  eax, 4
	call RandomRange
	inc  eax
	mov  playerSuit[esi], eax
	
	invoke printBackCard , playerPosition
	add  playerPosition.x, 12
	add  esi,4
	loop PlayerRandom
	pop esi
	pop ecx
	mov  playerPosition.x, 2
	
	; 印出莊家牌
dealerRandom:
	mov  eax, 13
	call RandomRange
	inc  eax
	.IF eax == playerNumber[0] || eax == playerNumber[4] || eax == playerNumber[8]
		jmp dealerRandom
	.ENDIF
	mov  dealerNumber, eax
	
	mov  eax, 4
	call RandomRange
	inc  eax
	mov  dealerSuit, eax
	
	invoke printBackCard , dealerPosition
; -----------------------------------------------------------------
; 玩家 choose 1
select1:

	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR selection1, 
      SIZEOF selection1,        
      selectionPosition,      
      ADDR cellsWritten

	jmp read
; 玩家 choose 2
select2:

	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR selection2, 
      SIZEOF selection2,        
      selectionPosition,      
      ADDR cellsWritten 

	jmp read
; 玩家 choose 3
select3:

	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR selection3, 
      SIZEOF selection3,        
      selectionPosition,      
      ADDR cellsWritten

	jmp read
; 玩家選牌
read:
	xor eax, eax
	call ReadChar
	.IF ax == 1C0Dh					;enter
		jmp choosing
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
	.IF selectionStatus == 3
		jmp select3
	.ENDIF
	.IF selectionStatus < 1
		mov selectionStatus, 1
		jmp select1
	.ENDIF
	.IF selectionStatus > 3
		mov selectionStatus, 3
		jmp select3
	.ENDIF
	jmp read
; -----------------------------------------------------------------
choosing:
	; 選第一張牌
	.IF selectionStatus == 1
		INVOKE printCard, playerSuit[0], playerNumber[0], playerPosition
		add  playerPosition.x, 12
		INVOKE printBackCard , playerPosition
		add  playerPosition.x, 12
		INVOKE printBackCard , playerPosition
	; 選第二張牌	
	.ELSEIF selectionStatus == 2
		INVOKE printBackCard , playerPosition
		add  playerPosition.x, 12
		INVOKE printCard, playerSuit[4], playerNumber[4], playerPosition
		add  playerPosition.x, 12
		INVOKE printBackCard , playerPosition
	; 選第三張牌	
	.ELSEIF selectionStatus == 3
		INVOKE printBackCard , playerPosition
		add  playerPosition.x, 12
		INVOKE printBackCard , playerPosition
		add  playerPosition.x, 12
		INVOKE printCard, playerSuit[8], playerNumber[8], playerPosition
	.ENDIF
	; 翻開覆蓋的莊家牌
	INVOKE sleep, 500
	INVOKE printCard, dealerSuit[8], dealerNumber, dealerPosition
	jmp bigsmall1
	
; 比牌的大小

bigsmall1:
	mov	ebx,dealerNumber
	.IF 	selectionStatus == 1
		cmp	playerNumber[0], ebx
		ja	win
		jb	lose
		je	bigsmall2
	.ELSEIF selectionStatus == 2
		cmp playerNumber[4], ebx
		ja	win
		jb	lose
		je	bigsmall2
	.ELSEIF selectionStatus == 3
		cmp playerNumber[8], ebx
		ja	win
		jb	lose
		je	bigsmall2
	.ENDIF
; 比花色大小
bigsmall2:
	mov	ebx,dealerSuit
	.IF 	selectionStatus == 1
		cmp	playerSuit[0], ebx
		ja	win
		jb	lose
	.ELSEIF selectionStatus == 2
		cmp playerSuit[4], ebx
		ja	win
		jb	lose
	.ELSEIF selectionStatus == 3
		cmp playerSuit[8], ebx
		ja	win
		jb	lose
	.ENDIF
; -----------------------------------------------------------------
win:
	; 加進總金額
	mov ebx, betMoney
	add esi, ebx
	
	INVOKE showStatus, 3
	jmp num2Str
lose:
	; 輸的錢扣在總金額
	mov ebx, betMoney
	sub esi, ebx
	
	INVOKE showStatus, 4
	jmp num2Str
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

; ------一回遊戲結束-----------------------------------------------------------
; 判斷是否破產
	.IF esi <= 0
		INVOKE sleep, 500
		jmp exitGame
	.ENDIF
; 詢問是否繼續
again1:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,     
      ADDR againStr1, 
      SIZEOF againStr1,        
      againPosition,      
      ADDR cellsWritten
	jmp read2
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
	
	; initial
	mov statusPosition.x, 0
	mov statusPosition.y, 21
	
	mov playerPosition.x, 2
	mov playerPosition.y, 10
	
	mov pleasePosition.x, 0
	mov pleasePosition.y, 7
	
	mov selectionStatus, 1
	
	mov betMoneyStr[0],0
	mov betMoneyStr[1],0
	mov betMoneyStr[2],0
	mov betMoneyStr[3],0
	
	call Clrscr
	
	.IF againStatus == 1
		mov againStatus, 1
		jmp Start
	.ELSE
		mov againStatus, 1
		jmp exitGame
	.ENDIF
	
	
exitGame:
    ret
	
bs2 ENDP

END


