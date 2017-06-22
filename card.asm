INCLUDE mylib.inc
main	EQU start@0

.data

.code

printCard PROC USES ecx esi ,suit:DWORD , number:DWORD , site:COORD

INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov outputHandle, eax

printCardTop:
	; 印出牌頂
	INVOKE WriteConsoleOutputCharacter, 
	  outputHandle,
      ADDR CardTop,
      7,
      site,
      ADDR cellsWritten

    inc site.y
	
	
	; 印出右上角花色 
	cmp suit, 1
	je	L
	cmp suit, 2
	je	D
	cmp suit, 3
	je	H
	cmp suit, 4
	je	S
H:
	cmp number, 1
	je PrintHR2
	cmp number, 2
	je PrintHR3
	cmp number, 3
	je PrintHR4
	cmp number, 4
	je PrintHR5
	cmp number, 5
	je PrintHR6
	cmp number, 6
	je PrintHR7
	cmp number, 7
	je PrintHR8
	cmp number, 8
	je PrintHR9
	cmp number, 9
	je PrintHR10
	cmp number, 10
	je PrintHRJ
	cmp number, 11
	je PrintHRQ
	cmp number, 12
	je PrintHRK
	cmp number, 13
	je PrintHR1
D:
	cmp number, 1
	je PrintDR2
	cmp number, 2
	je PrintDR3
	cmp number, 3
	je PrintDR4
	cmp number, 4
	je PrintDR5
	cmp number, 5
	je PrintDR6
	cmp number, 6
	je PrintDR7
	cmp number, 7
	je PrintDR8
	cmp number, 8
	je PrintDR9
	cmp number, 9
	je PrintDR10
	cmp number, 10
	je PrintDRJ
	cmp number, 11
	je PrintDRQ
	cmp number, 12
	je PrintDRK
	cmp number, 13
	je PrintDR1
L:
	cmp number, 1
	je PrintCR2
	cmp number, 2
	je PrintCR3
	cmp number, 3
	je PrintCR4
	cmp number, 4
	je PrintCR5
	cmp number, 5
	je PrintCR6
	cmp number, 6
	je PrintCR7
	cmp number, 7
	je PrintCR8
	cmp number, 8
	je PrintCR9
	cmp number, 9
	je PrintCR10
	cmp number, 10
	je PrintCRJ
	cmp number, 11
	je PrintCRQ
	cmp number, 12
	je PrintCRK
	cmp number, 13
	je PrintCR1
S:
	cmp number, 1
	je PrintSR2
	cmp number, 2
	je PrintSR3
	cmp number, 3
	je PrintSR4
	cmp number, 4
	je PrintSR5
	cmp number, 5
	je PrintSR6
	cmp number, 6
	je PrintSR7
	cmp number, 7
	je PrintSR8
	cmp number, 8
	je PrintSR9
	cmp number, 9
	je PrintSR10
	cmp number, 10
	je PrintSRJ
	cmp number, 11
	je PrintSRQ
	cmp number, 12
	je PrintSRK
	cmp number, 13
	je PrintSR1

	; 印出牌身
	
printCardBody:
	push ecx ; save counter	
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardBody,
      7,
      site,
      ADDR cellsWritten
	  
    inc site.y   ; next line
	
    pop ecx   ; restore counter
    loop printCardBody
	
	; 印出左下角花色
	cmp suit, 1
	je	Lleft
	cmp suit, 2
	je	Dleft
	cmp suit, 3
	je	Hleft
	cmp suit, 4
	je	Sleft
Hleft:
	cmp number, 1
	je PrintHL2
	cmp number, 2
	je PrintHL3
	cmp number, 3
	je PrintHL4
	cmp number, 4
	je PrintHL5
	cmp number, 5
	je PrintHL6
	cmp number, 6
	je PrintHL7
	cmp number, 7
	je PrintHL8
	cmp number, 8
	je PrintHL9
	cmp number, 9
	je PrintHL10
	cmp number, 10
	je PrintHLJ
	cmp number, 11
	je PrintHLQ
	cmp number, 12
	je PrintHLK
	cmp number, 13
	je PrintHL1
Dleft:
	cmp number, 1
	je PrintDL2
	cmp number, 2
	je PrintDL3
	cmp number, 3
	je PrintDL4
	cmp number, 4
	je PrintDL5
	cmp number, 5
	je PrintDL6
	cmp number, 6
	je PrintDL7
	cmp number, 7
	je PrintDL8
	cmp number, 8
	je PrintDL9
	cmp number, 9
	je PrintDL10
	cmp number, 10
	je PrintDLJ
	cmp number, 11
	je PrintDLQ
	cmp number, 12
	je PrintDLK
	cmp number, 13
	je PrintDL1
Lleft:
	cmp number, 1
	je PrintCL2
	cmp number, 2
	je PrintCL3
	cmp number, 3
	je PrintCL4
	cmp number, 4
	je PrintCL5
	cmp number, 5
	je PrintCL6
	cmp number, 6
	je PrintCL7
	cmp number, 7
	je PrintCL8
	cmp number, 8
	je PrintCL9
	cmp number, 9
	je PrintCL10
	cmp number, 10
	je PrintCLJ
	cmp number, 11
	je PrintCLQ
	cmp number, 12
	je PrintCLK
	cmp number, 13
	je PrintCL1
Sleft:
	cmp number, 1
	je PrintSL2
	cmp number, 2
	je PrintSL3
	cmp number, 3
	je PrintSL4
	cmp number, 4
	je PrintSL5
	cmp number, 5
	je PrintSL6
	cmp number, 6
	je PrintSL7
	cmp number, 7
	je PrintSL8
	cmp number, 8
	je PrintSL9
	cmp number, 9
	je PrintSL10
	cmp number, 10
	je PrintSLJ
	cmp number, 11
	je PrintSLQ
	cmp number, 12
	je PrintSLK
	cmp number, 13
	je PrintSL1
	
	
    ; 印出牌底
printCardBottom:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardBottom,  ; pointer to the bottom of the box
      7,
      site,
      ADDR cellsWritten



    ret
	
; set card------------------------------------------------------------------
	
PrintHR1:    ;H = heart R = 右上  1 = 數字(右上位置印出愛心1)
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR1,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL1:     ;H = heart L = 左下  1 = 數字(左下位置印出愛心1
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL1,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHR2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR2,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL2,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4    ; number of lines in body
   	jmp printCardBottom

PrintHR3:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR3,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4    ; number of lines in body
   	jmp printCardBody

PrintHL3:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL3,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHR4:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR4,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL4:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL4,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHR5:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR5,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL5:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL5,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHR6:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR6,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL6:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL6,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHR7:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR7,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL7:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL7,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHR8:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR8,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL8:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL8,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHR9:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR9,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL9:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL9,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHR10:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHR10,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHL10:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHL10,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHRJ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHRJ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHLJ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHLJ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHRQ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHRQ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHLQ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHLQ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintHRK:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHRK,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintHLK:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardHLK,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR1:     ;D = diamond R = 右上  1 = 數字(右上位置印出菱形1
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR1,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL1:     ;D = diamond L = 左下  1 = 數字(左下位置印出菱形1
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL1,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR2,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL2,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4    ; number of lines in body
   	jmp printCardBottom

PrintDR3:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR3,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4    ; number of lines in body
   	jmp printCardBody

PrintDL3:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL3,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR4:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR4,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL4:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL4,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR5:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR5,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL5:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL5,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR6:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR6,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL6:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL6,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR7:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR7,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL7:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL7,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR8:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR8,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL8:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL8,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR9:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR9,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL9:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL9,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDR10:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDR10,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDL10:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDL10,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDRJ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDRJ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDLJ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDLJ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDRQ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDRQ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDLQ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDLQ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintDRK:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDRK,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintDLK:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardDLK,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR1:		;C = club R = 右上  1 = 數字(右上位置印出梅花1
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR1,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL1:		;C = club L = 左下  1 = 數字(左下位置印出梅花1
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL1,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR2,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL2,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4    ; number of lines in body
   	jmp printCardBottom

PrintCR3:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR3,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4    ; number of lines in body
   	jmp printCardBody

PrintCL3:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL3,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR4:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR4,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL4:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL4,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR5:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR5,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL5:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL5,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR6:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR6,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL6:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL6,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR7:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR7,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL7:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL7,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR8:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR8,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL8:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL8,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR9:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR9,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL9:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL9,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCR10:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCR10,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCL10:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCL10,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCRJ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCRJ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCLJ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCLJ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCRQ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCRQ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCLQ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCLQ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintCRK:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCRK,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintCLK:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardCLK,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR1:		;S = spare R = 右上  1 = 數字(右上位置印出黑桃1
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR1,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL1:		;S = spare L = 左下  1 = 數字(左下位置印出黑桃1
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL1,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR2,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL2:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL2,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4    ; number of lines in body
   	jmp printCardBottom

PrintSR3:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR3,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4    ; number of lines in body
   	jmp printCardBody

PrintSL3:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL3,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR4:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR4,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL4:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL4,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR5:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR5,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL5:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL5,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR6:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR6,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL6:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL6,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR7:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR7,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL7:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL7,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR8:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR8,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL8:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL8,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR9:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR9,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL9:
	INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL9,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSR10:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSR10,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSL10:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSL10,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSRJ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSRJ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSLJ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSLJ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSRQ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSRQ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSLQ:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSLQ,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom

PrintSRK:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSRK,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBody

PrintSLK:
    INVOKE WriteConsoleOutputCharacter,
	  outputHandle,
      ADDR CardSLK,
      7,
      site,
      ADDR cellsWritten

	inc site.y

    mov ecx, 4
   	jmp printCardBottom
	

printCard ENDP


END 


