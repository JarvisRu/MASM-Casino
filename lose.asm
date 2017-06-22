INCLUDE mylib.inc

WriteConsoleOutputCharacter PROTO,
	handleScreenBuf:DWORD,			; console output handle
	pBuffer:PTR BYTE,				; pointer to buffer
	bufsize:DWORD,					; size of buffer
	xyPos:COORD,					; first cell coordinates
	pCount:PTR DWORD					; output count
print_lose PROTO, 
		string:ptr, position:COORD

.data 
loserPosition COORD <25,8>

lose1   byte " ____    _    _   _ _  ______  _   _ ____ _____ "
lose2   byte "| __ )  / \  | \ | | |/ |  _ \| | | |  _ |_   _|"
lose3   byte "|  _ \ / _ \ |  \| | ' /| |_) | | | | |_) || |  "
lose4   byte "| |_) / ___ \| |\  | . \|  _ <| |_| |  __/ | |  "
lose5   byte "|____/_/   \_|_| \_|_|\_|_| \_\\___/|_|    |_|  "
lose6   byte "                   ____   ____                  "
lose7   byte "                  / __ \ / __ \                 "
lose8   byte "                 | |  | | |  | |                "
lose9   byte "                 | |  | | |  | |                "
lose10  byte "                 | |__| | |__| |                "
lose11  byte "                  \___\_\\___\_\                "




.code
print_lose PROC, 
		string:ptr, position:COORD
	INVOKE WriteConsoleOutputCharacter,
		outputHandle,   					; console output handle
		string,   						; pointer to the top box line
		48,   						; size of box line
		position,   						; coordinates of first char
		ADDR count
	inc loserPosition.y
	ret
print_lose ENDP


loser PROC

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE  ; Get the console ouput handle
    mov outputHandle, eax 				; save console handle
	
    call Clrscr
	
	INVOKE print_lose, addr lose1, loserPosition
	INVOKE print_lose, addr lose2, loserPosition
	INVOKE print_lose, addr lose3, loserPosition
	INVOKE print_lose, addr lose4, loserPosition
	INVOKE print_lose, addr lose5, loserPosition
	INVOKE print_lose, addr lose6, loserPosition
	INVOKE print_lose, addr lose7, loserPosition
	INVOKE print_lose, addr lose8, loserPosition
	INVOKE print_lose, addr lose9, loserPosition
	INVOKE print_lose, addr lose10, loserPosition
	INVOKE print_lose, addr lose11, loserPosition
    ret
	
loser ENDP

END 
 
