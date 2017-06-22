INCLUDE mylib.inc
main	EQU start@0

.data

.code

showStatus PROC USES esi ,status:byte
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
	 
	; print bottom bar
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,    
		  ADDR barBottom, 
		  SIZEOF barBottom,        
		  statusPosition,      
		  ADDR cellsWritten
		add statusPosition.y, 1
		
	; 1 : 詢問賭金
	.IF status == 1
		; print "input money : "
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR inputMoneyStr, 
		  SIZEOF inputMoneyStr,        
		  statusPosition,      
		  ADDR cellsWritten 

		; set cursor position
		INVOKE SetConsoleCursorPosition, outputHandle, cursorPosition

		add statusPosition.y, 1
		; print bottom bar2
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR barBottom2, 
		  SIZEOF barBottom2,        
		  statusPosition,      
		  ADDR cellsWritten
		add statusPosition.y, 1
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR barBottom2, 
		  SIZEOF barBottom2,        
		  statusPosition,      
		  ADDR cellsWritten
		; read input money 
		call   ReadInt
		mov    betMoney , eax
		
	; 2 : 平手 
	.ELSEIF status == 2
		; print "Tied!!! "
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR wrTied, 
		  SIZEOF wrTied,        
		  statusPosition,      
		  ADDR cellsWritten 
		 
		add statusPosition.y, 1
		; print bottom bar2
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR barBottom2, 
		  SIZEOF barBottom2,        
		  statusPosition,      
		  ADDR cellsWritten
		add statusPosition.y, 1
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR barBottom2, 
		  SIZEOF barBottom2,        
		  statusPosition,      
		  ADDR cellsWritten
	; 3 : 獲勝 贏得 $  
	.ELSEIF status == 3
		; print "You win!!!  Get $ "
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR wrWin, 
		  SIZEOF wrWin,        
		  statusPosition,      
		  ADDR cellsWritten 
		 
		add statusPosition.y, 1
		; print bottom bar2
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR barBottom2, 
		  SIZEOF barBottom2,        
		  statusPosition,      
		  ADDR cellsWritten
		add statusPosition.y, 1
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR barBottom2, 
		  SIZEOF barBottom2,        
		  statusPosition,      
		  ADDR cellsWritten
	; 4 : 輸了QQ  輸$  
	.ELSEIF status == 4
		; print "You lose Q! Lose $ "
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR wrLose, 
		  SIZEOF wrLose,        
		  statusPosition,      
		  ADDR cellsWritten 
		 
		add statusPosition.y, 1
		; print bottom bar2
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR barBottom2, 
		  SIZEOF barBottom2,        
		  statusPosition,      
		  ADDR cellsWritten
		add statusPosition.y, 1
		INVOKE WriteConsoleOutputCharacter,
		  outputHandle,     
		  ADDR barBottom2, 
		  SIZEOF barBottom2,        
		  statusPosition,      
		  ADDR cellsWritten
	.ENDIF

	mov statusPosition.x, 0
	mov statusPosition.y, 21
	
    ret
showStatus ENDP

END 