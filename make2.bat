@echo off
REM make
REM Assembles and links the 32-bit ASM program into .exe which can be used by WinDBG
REM Uses MicroSoft Macro Assembler version 6.11 and 32-bit Incremental Linker version 5.10.7303
REM Created by Huang

REM delete related files
del FP.lst	REM test可以替換成.asm檔的檔名
del FP.obj
del FP.ilk
del FP.pdb
del FP.exe

setlocal
set INCLUDE=D:\Assembly Language\WINdbgFolder;	REM 這裡要設成WINdbgFolder的路徑
set LIB=D:\Assembly Language\WINdbgFolder;
set PATH=D:\Assembly Language\WINdbgFolder;

REM /c          assemble without linking
REM /coff       generate object code to be linked into flat memory model
REM /Zi         generate symbolic debugging information for WinDBG
REM /Fl		Generate a listing file


ML /c /coff /Zi  FP.asm bs2.asm card.asm statusBar.asm backCard.asm topBar.asm twentyOne.asm ten.asm lose.asm sm2.asm
if errorlevel 1 goto terminate

REM /debug              generate symbolic debugging information
REM /subsystem:console  generate console application code
REM /entry:start        entry point from WinDBG to the program
REM                           the entry point of the program must be _start

REM /out:%1.exe         output %1.exe code
REM %1.obj              input %1.obj
REM Kernel32.lib        library procedures to be invoked from the program
REM irvine32.lib
REM user32.lib

LINK /INCREMENTAL:no /debug /subsystem:console /entry:start /out:FP.exe FP.obj Kernel32.lib irvine32.lib user32.lib  card.obj statusBar.obj backCard.obj bs2.obj topBar.obj twentyOne.obj ten.obj lose.obj sm2.obj
if errorlevel 1 goto terminate

REM Display all files related to this program:
DIR FP.*

:terminate
pause
endlocal
