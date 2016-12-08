
# tout : Timed output

This tout command reads input a line, wait some seconds, and output it.
The waiting time is specified by invocation argument
or 1st one field(space delimited) of each other.

## Installation

Install posix-extras and Compile.

```shell
chicken-install posix-extras
csc tout.scm
```

## Usage

Execute below script on Raspberry Pi.

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
