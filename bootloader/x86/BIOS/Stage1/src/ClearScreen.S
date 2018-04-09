.code16
.section .text
.org 0x0

/// Clears the screen
///
/// Input:
///  NONE
/// Output:
///  NONE
.global ClearScreen
ClearScreen:
	PUSHA

	MOVw $0x0600, %AX
	MOVb $0x07, %BH
	MOVw $0x0000, %CX
	MOVw $0xFFFF, %DX
	INT $0x10

	MOVb $0x02, %AH
	MOVb $0x00, %BH
	MOVw $0x0000, %DX
	INT $0x10

	POPA
	RET
