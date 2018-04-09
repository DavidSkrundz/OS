OUTPUT_FORMAT(binary)

SECTIONS {
	.text : {
		*Stage1.o(.text)
		*(.text)
	}
	.data : {
		*(.data)
	}
}
