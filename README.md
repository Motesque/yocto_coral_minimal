# Minimal Image for Running Coral TPU
This repo is meant to provide a simple way to test an issue running a Coral PCI module with the Variscite MX8M-MINI development board. When used with the MX8M-MINI that has an audio codec, the Coral TPU seems to work fine. When used with a MX8M-MINI that does NOT have an audio codec, the Coral TPU does not work.

Dunfell based Yocto image built in Docker
https://embeddeduse.com/2019/02/11/using-docker-containers-for-yocto-builds/

https://variwiki.com/index.php?title=Yocto_Build_Release&release=RELEASE_DUNFELL_V1.1_DART-MX8M-MINI
bitbake -c menuconfig virtual/kernel

## Docker Setup on Host (ubuntu) machine
To avoid sudo on the host machine, use these commands
1. Create the docker group, if doesn't exist
* sudo groupadd docker
2. Add user to the docker group
* sudo usermod -aG docker $USER
3. Activate the changes to groups
* newgrp docker 

## Building the Yocto image
* execute . ./build.sh on the host to create the docker image
* execute . ./run.sh to run the container and open a terminal. 
* In the container, use `. run_me_first.sh` and then `bitbake core-image-base`


## Coral TPU Example
The Coral examples are in:
`cd /usr/share/edgetpu/examples`

To test if the TPU is working, from the above directory run:
```
python3 classify_image.py \
    --model models/mobilenet_v2_1.0_224_inat_bird_quant_edgetpu.tflite \
    --label models/inat_bird_labels.txt \
    --image images/parrot.jpg
```
