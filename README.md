# nCube
coloful notifications on a decorative cube

## Installation

flash the firmware located in `/firmware` using `esptool` like this
```bash
esptool.py --port /dev/ttyUSB0 write_flash -fm dio 0x00000 nodemcu_ncube_20201116.bin
```

upload the lua files
```bash
npm run upload
```

upload the lfs image
```bash
alias nu="node ./node_modules/nodemcu-tool/bin/nodemcu-tool.js"
nu upload lfs.img
nu terminal
node.setpartitiontable{lfs_size = 0x20000, spiffs_addr = 0x120000, spiffs_size = 0x20000}
node.LFS.reload("lfs.img")
```

