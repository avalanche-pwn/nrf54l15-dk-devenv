# nRF54L15-dk workspace

This is a collection of docker images which can be used to develop for
nRF54L15-dk boards.  (There is not much board specific setup so you might be
able to use it with other boards if you edit build_env.sh script accordingly -
look at $board var).

## Building and using the environment
> All the scripts here assume default linux configuration where sudo is
> required to run docker. If you have a different configuration and want to
> avoid running unnecessary sudo add --no-sudo to all commands.

To get started clone this repository and run
```bash
./build_docker_images.sh
```
This will create 3 images
- nordic - an image based on the official
  [nordic docker image](https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/scripts/docker/README.html)
- plain - a plain zephyr image that was used for experimentation and probably doesn't work as of now
- bsim - an image used for building babblesim - it is only used for building, after babblesim is built in can be used from inside of the nrf image

The nordic image is based on nRF Connect SDK version 3.1.1 if you want to change
this edit the version number inside of nordic/Dockerfile.

The build_env.sh script is intended to be used as an entry to the dev environment
it will launch a docker image with all the necessary arguments.

The supported options are
```
--docker IMAGE_TYPE - which docker container to use - can be either nrf or plain
--bsim - Switch the target board from default - nrf54l15dk/nrf54l15/cpuapp to babblesim one - nrf54l15bsim/nrf54l15/cpuapp
--enable-ns - This makes the default target use the non secure flag which enables the use of Trusted Firmware-M and PSA api.
```

## About TFM
TFM is an implementation of Secure Processing Environment it is only available
for boards which have ns target eg. nrf54l15dk/nrf54l15/cpuapp/ns.
It allows for usage of PSA crypto secure api.


# Recognition
This was done as a part of my bachelor thesis under supervision
of PhD Marek Bawiec from Wrocław University of Science and Technology.
