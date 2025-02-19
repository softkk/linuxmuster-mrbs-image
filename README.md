# MRBS Docker Image 

Ein angepasstes Docker Image mit MRBS für linuxmuster.net. Um das Image zu verwenden, installiere die APP: 
https://github.com/linuxmuster-ext-docker/linuxmuster-mrbs

## To build:

```
git clone https://github.com/softkk/linuxmuster-mrbs-image.git
cd linuxmuster-mrbs-image
wget https://sourceforge.net/projects/mrbs/files/mrbs/MRBS%201.11.6/mrbs-1.11.6.zip/download -O mrbs-1.11.6.zip
unzip mrbs-1.11.6.zip
podman build -t softkk/mrbs:1.11.6 .
```
