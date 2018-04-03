AC_INIT([OS], [0.0])



dnl ****************************************************************************
dnl * Block Size
dnl ****************************************************************************
AC_ARG_WITH([block-size],
            [AS_HELP_STRING([--with-block-size=<size>],
                            [specify the block size ([512], 4096)])])

if test -z "$with_block_size"
then
	with_block_size=512
fi

test "$with_block_size" -eq "$with_block_size" 2>/dev/null
if test $? -ne 0
then
	AC_MSG_ERROR([block-size is not a number])
fi

case "$with_block_size" in
	512)	;;
	4096)	;;
	*) 		AC_MSG_ERROR([block-size not a supported value ([512], 4096)])
			;;
esac



dnl ****************************************************************************
dnl * Architecture
dnl ****************************************************************************
AC_ARG_WITH([arch],
            [AS_HELP_STRING([--with-arch=<arch>],
                            [specify the architecture ([x86])])])

if test -z "$with_arch"
then
	with_arch=x86
fi

case "$with_arch" in
	x86)	;;
	*) 		AC_MSG_ERROR([architecture ($with_arch) not supported ([x86])])
			;;
esac



dnl ****************************************************************************
dnl * x86
dnl ****************************************************************************
AC_ARG_WITH([32bit],
            [AS_HELP_STRING([--with-32bit],
                            [include 32bit support])])
AC_ARG_WITH([64bit],
            [AS_HELP_STRING([--with-64bit],
                            [include 64bit support])])
AC_ARG_WITH([format],
            [AS_HELP_STRING([--with-format=<format>],
                            [specify disk format ([mbr], gpt)])])
AC_ARG_WITH([bios],
            [AS_HELP_STRING([--with-bios],
                            [include BIOS support])])
AC_ARG_WITH([efi],
            [AS_HELP_STRING([--with-efi],
                            [include EFI support])])

if test -z "$with_32bit" && test -z "$with_64bit"
then
	AC_MSG_ERROR([Either 32bit or 64bit must be supported])
fi

if test -z "$with_32bit"
then
	with_32bit=no
fi

if test -z "$with_64bit"
then
	with_64bit=no
fi

if test -z "$with_format"
then
	with_format=mbr
fi

if test -z "$with_bios" && test -z "$with_efi"
then
	AC_MSG_ERROR([Either BIOS or EFI must be supported])
fi

if test -z "$with_bios"
then
	with_bios=no
fi

if test -z "$with_efi"
then
	with_efi=no
fi



dnl ****************************************************************************
dnl * Output
dnl ****************************************************************************
AC_SUBST([block_size], [$with_block_size])
AC_SUBST([architecture], [$with_arch])
AC_SUBST([bit32], [$with_32bit])
AC_SUBST([bit64], [$with_64bit])
AC_SUBST([format], [$with_format])
AC_SUBST([bios], [$with_bios])
AC_SUBST([efi], [$with_efi])
AC_OUTPUT([Makefile])
