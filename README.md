
# tout : Timed output

Tout command reads a line from standard input, wait some seconds,
and write it to standard output.
The waiting time is specified by invocation argument
or 1st one field(space delimited) of each line.

## Compilation & Installation

Use [Chicken Scheme](https://www.call-cc.org/) Compiler 4.10.0 later to compile ``tout.scm''.
Install posix-extras and Compile.

```shell
chicken-install posix-extras
csc tout.scm
```

## Usage

Execute this script on Raspberry Pi.

```shell
#!/bin/sh

echo "4" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio4/direction

yes '1 1
2 0'		|
tout		|
tr -d ' '	|
dd bs=2 > /sys/class/gpio/gpio4/value
```
