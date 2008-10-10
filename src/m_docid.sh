#!/bin/sh
echo | tai64 | sed 's/@/SFD/' | sed 's/ *//g'
