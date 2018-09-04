.code16
.section .text
.org 0x0

/******************************************************************************\
| Stage2 Entry                                                                 |
\******************************************************************************/
Start:

Program:
	LEAw String, %SI
	CALL PrintString

	CALL CheckA20
	JC .A20Disabled

	LEAw A20EnabledString, %SI
	CALL PrintString

Halt:
	CLI
	HLT
	JMP Halt

.A20Disabled:
	LEAw A20DisabledString, %SI
	CALL PrintString
	JMP Halt


/******************************************************************************\
| Data Section                                                                 |
\******************************************************************************/
.section .data

String:
	.asciz "Stage 2 print\r\n"
A20EnabledString:
	.asciz "A20 Enabled\r\n"
A20DisabledString:
	.asciz "A20 Disabled\r\n"
