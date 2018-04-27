.code16
.section .text
.org 0x0

/******************************************************************************\
| Preprocessor Defines                                                         |
\******************************************************************************/
/// BLOCK_SIZE - Bytes per sector
/// STAGE2_LBA  - Starting LBA of Stage2
/// STAGE2_SIZE - Size of Stage2 in sectors


/******************************************************************************\
| Constants                                                                    |
\******************************************************************************/
.set BYTES_PER_SECTOR, BLOCK_SIZE
.set LBA_TO_LOAD, STAGE2_LBA
.set SECTORS_TO_LOAD, STAGE2_SIZE

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
	CALL ClearScreen

	LEAw String, %SI
	CALL PrintString

	CALL CheckDiskLBAExtension
	JC ExtensionError

	MOVw $BOOT_SEGMENT, %AX
	MOVw %AX, %DS
	MOVw $0, %AX
	MOVw %AX, %SI
	MOVw $LBA_TO_LOAD, %AX
	MOVw $SECTORS_TO_LOAD, %BX
	CALL ReadDisk
	JC ReadError

	JMP $BOOT_SEGMENT, $Start


ExtensionError:
	LEAw ExtensionErrorString, %SI
	CALL PrintString
	JMP Halt

ReadError:
	MOVw $RELOCATE_SEGMENT, %AX
	MOVw %AX, %DS
	LEAw ReadErrorString, %SI
	CALL PrintString
	JMP .

Halt:
	CLI
	HLT
	JMP Halt


/******************************************************************************\
| Data Section                                                                 |
\******************************************************************************/
.section .data

String:
	.asciz "Stage 1 print\r\n"

ExtensionErrorString:
	.asciz "BIOS does not support LBA addressing.\r\n"

ReadErrorString:
	.asciz "Could not read disk.\r\n"
