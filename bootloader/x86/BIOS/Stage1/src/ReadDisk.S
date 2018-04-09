.code16
.section .text
.org 0x0

/// Read from disk
///
/// Input:
///  - `DL`: Drive index
///  - `AX`: LBA of first sector to read
///  - `BX`: Number of sectors to read
///  - `DS:SI`: String start address
/// Output:
///  - `Carry bit`: clear if successful
.global ReadDisk
ReadDisk:
	PUSHA

	MOVw %AX, .DAPTargetSector
	MOVw %BX, .DAPSectors
	MOVw %DS, .DAPTargetPointerSegment
	MOVw %SI, .DAPTargetPointerOffset
	MOVb $0x42, %AH
	LEAw .DiskAddressPacket, %SI
	INT $0x13

	POPA
	RET


/******************************************************************************\
| Data Section                                                                 |
\******************************************************************************/
.section .data

.DiskAddressPacket:
	.byte 0x10			// Size of DAP
	.byte 0				// Unused (zero)
.DAPSectors:
	.word 0				// Number of sectors to read (max 127)
.DAPTargetPointerOffset:
	.word 0				// Output buffer offset
.DAPTargetPointerSegment:
	.word 0				// Output buffer segment
.DAPTargetSector:
	.quad 0				// LBA of first sector to read
