.code16
.section .text
.org 0x0

/// Print a null-terminated string
///
/// Input:
///  - `DS:SI`: String start address
///  - `DF`: Specifies the direction to move the pointer (0 to increment)
/// Output:
///  - `SI`: Points to the null terminator
.global PrintString
PrintString:
	PUSHA

	MOVb $0x0E, %AH
	MOVw $0, %BX
.PrintStringStart:
	LODSb
	TESTb %AL, %AL
	JZ .PrintStringEnd
	INT $0x10
	JMP .PrintStringStart
.PrintStringEnd:

	POPA
	RET
