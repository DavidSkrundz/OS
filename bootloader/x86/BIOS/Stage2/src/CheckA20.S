.code16
.section .text
.org 0x0

/// Check if the A20 line is enabled
///
/// Input:
///  NONE
/// Output:
///  - `Carry bit`: set if disabled
.global CheckA20
CheckA20:
	PUSHA
	PUSH %DS
	PUSH %ES
	CLI

	// Low segment (0x0000)
	XOR %AX, %AX
	MOVw %AX, %ES

	// High segment (0xFFFF)
	NOT %AX
	MOVw %AX, %DS

	// ES:DI -> 0x0000:0x0500
	MOVw $0x0500, %DI
	// DS:SI -> 0xFFFF:0x0510
	MOVw $0x0510, %SI

	// Store the previous values
	MOVb %ES:(%DI), %AL
	MOVb %DS:(%SI), %AH

	// Write different values
	MOVb $0xFF, %ES:(%DI)
	MOVb $0x00, %DS:(%SI)

	// Compare the low value with the expected high value if A20 is disabled
	// If `%ES:(%DI)` contains `0x00` the carry bit is set
	// If `%ES:(%DI)` contains `0xFF` the carry bit is cleared
	CMPb $0xFF, %ES:(%DI)

	// Restore the original values
	MOVb %AL, %ES:(%DI)
	MOVb %AH, %DS:(%SI)

	STI
	POP %ES
	POP %DS
	POPA
	RET
