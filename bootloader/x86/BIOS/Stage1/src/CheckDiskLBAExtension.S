.code16
.section .text
.org 0x0

// Check Extensions Present
//
// Input:
//  - `DL`: Drive index
// Output:
//  - `Carry bit`: clear if LBA extension is present
.global CheckDiskLBAExtension
CheckDiskLBAExtension:
	PUSHA

	MOVb $0x41, %AH
	MOVw $0x55AA, %BX
	INT $0x13

	POPA
	RET
