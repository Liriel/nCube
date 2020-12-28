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

