#!/bin/sh

if [ $# -eq 0 ]
then
    BINARY=efm32-test.bin
else
    BINARY=$1
fi


ESCAPED_BINARY=$(printf '%s\n' "$BINARY" | sed -e 's/[\/&]/\\&/g')
sed "s/BINARY/${ESCAPED_BINARY}/" < flash.jlink > build/flash.jlink

JLinkExe -device EFM32GG11B820F2048GL192 -speed 4000 -if SWD -CommanderScript build/flash.jlink