.code16
.section .text
.org 0x0

/******************************************************************************\
| Constants                                                                    |
\******************************************************************************/
// End of free space
.set STACK_SEGMENT, 0x9FC0
// Where the MBR is loaded
.set BOOT_SEGMENT, 0x07C0


/******************************************************************************\
| MBR Bootloader Entry                                                         |
\******************************************************************************/
Start:
	// Disable interrupts during critical operations
	CLI

	MOVw $BOOT_SEGMENT, %AX
	MOVw %AX, %DS

	// Prepare the stack
	MOVw $STACK_SEGMENT, %AX
	MOVw %AX, %BP
	MOVw %AX, %SP

	// Enable interrupts
	STI

Program:
	LEAw String, %SI
	CALL PrintString

Halt:
	CLI
	HLT
	JMP Halt


/******************************************************************************\
| Data Section                                                                 |
\******************************************************************************/
.section .data

String:
	.asciz "A string to print\r\n"
