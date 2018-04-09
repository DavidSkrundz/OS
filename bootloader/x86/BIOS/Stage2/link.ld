OUTPUT_FORMAT(binary)

SECTIONS {
	.text : {
		*Stage2.o(.text)
		*(.text)
	}
	.data : {
		*(.data)
	}
}
