#!/bin/bash
LC=~/tmp/nodemcu/nodemcu-firmware/luac.cross
$LC -f -o lfs.img dummy_strings.lua _init.lua apicontroller.lua httpserver.lua wifihelper.lua server.lua fifo.lua fifosock.lua cancelpin.lua
