INCLUDE mylib.inc
main	EQU start@0

.data

.code

printBackCard PROC USES ecx esi , site:COORD

PrintBack:
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
		mov outputHandle, eax
	
	INVOKE WriteConsoleOutputCharacter, 
	  outputHandle,
      ADDR Card1Top,
      7,
      site,
      ADDR cellsWritten

    inc site.y
	mov ecx, 6
printCardBody:
	push ecx ; save counter
	
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR Card1Body,
      7,
      site,
      ADDR cellsWritten
	  
    inc site.y   ; next line
	
    pop ecx   ; restore counter
    loop printCardBody
	
printCardBottom:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR Card1Bottom,  ; pointer to the bottom of the box
      7,
      site,
      ADDR cellsWritten
		
	ret
printBackCard ENDP

END