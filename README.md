# OS

An Operating System


## Requirements

- `GNU bash`
- `GNU Make 4`

###### macOS
- Install command line developer tools (Xcode)
- Install [brew](https://brew.sh)
- `brew install make --with-default-names`
- `brew install gmp mpfr libmpc isl`
- `brew cask install mactex`

###### Ubuntu
- `sudo apt-get install libmpc-dev`
- `sudo apt-get install binutils-dev zlib1g-dev`
- `sudo apt-get install bison texinfo flex`
- `sudo apt-get install texlive-full`


## Building

(Optional) Documentation:

```Bash
cd docs
make
```

First build the toolchain:

```Bash
cd toolchain
make [-jn]
```

Then the rest:

```Bash
./configure <options>
make
```

## Configure Options

```
--with-block-size=<[512], 4096>
--with-arch=<[x86]>
```

### x86 Options

```
--with-32bit
--with-64bit
--with-format=<[mbr], gpt>
--with-bios
--with-efi
```
