.code16
.section .text
.org 0x0

/******************************************************************************\
| Preprocessor Defines                                                         |
\******************************************************************************/
/// BLOCK_SIZE - Bytes per sector


/******************************************************************************\
| Constants                                                                    |
\******************************************************************************/
.set BYTES_PER_SECTOR, BLOCK_SIZE

// End of free space
.set STACK_SEGMENT, 0x9FC0
// Where the MBR is loaded
.set BOOT_SEGMENT, 0x07C0
// Offset by one sector
.set RELOCATE_SEGMENT, BOOT_SEGMENT - (BYTES_PER_SECTOR >> 4)

// Moving words is twice as fast as moving bytes
.set WORDS_TO_RELOCATE, BYTES_PER_SECTOR >> 1


/******************************************************************************\
| MBR Bootloader Entry                                                         |
\******************************************************************************/
Start:
	// Disable interrupts during critical operations
	CLI

Relocate:
	// From segment
	MOVw $BOOT_SEGMENT, %AX
	MOVw %AX, %DS
	// To segment
	MOVw $RELOCATE_SEGMENT, %AX
	MOVw %AX, %ES
	// Set relocation counter
	MOVw $WORDS_TO_RELOCATE, %cx
	// Clear offsets - segments will be used instead
	XOR %SI, %SI
	XOR %DI, %DI
	// Do the move
	REP MOVSw
	// Long jump to the new code location
	LJMP $RELOCATE_SEGMENT, $Segmentation

Segmentation:
	// Point `DS` to the new code location (can't move constant into DS)
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

	CALL CheckDiskLBAExtension
	JC ExtensionError

	JMP Halt

ExtensionError:
	LEAw ExtensionErrorString, %SI
	CALL PrintString
	JMP Halt

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

ExtensionErrorString:
	.asciz "BIOS does not support LBA addressing.\r\n"
