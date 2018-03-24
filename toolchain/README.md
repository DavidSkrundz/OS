# OS Toolchain

The toolchain used to compile the OS

## Requirements

- `GNU bash`
- `GNU Make 4`

###### macOS
- `brew install gmp mpfr libmpc isl`
- `brew cleanup`

###### Ubuntu
- `sudo apt-get install libmpc-dev`
- `sudo apt-get install binutils-dev zlib1g-dev`
- `sudo apt-get install bison texinfo flex`

## Building

This will take a while.

```bash
make [-jn]
```

### Individual Component Targets

**Must be built in order** (i.e. `make X Y` won't work)

- `NATIVE_BINUTILS`
- `NATIVE_GCC`
- `CROSS_BINUTILS`
- `CROSS_GCC`
- `CROSS_MINGW`

## Cleaning

```bash
make clean           # Clean intermediate files
make clean-cross     # Clean intermediate files and cross-compilers
make clean-toolchain # Clean intermediate files and compilers
```
