#!/bin/env bash
set -e

pushd $PWD/workspace
board=nrf54l15dk/nrf54l15/cpuapp
IMAGE_TYPE=""
ENABLE_NS=0
DOCKER_PREFIX="sudo"

while [[ $# -gt 0 ]]; do
  case $1 in
    --bsim)
      board=nrf54l15bsim/nrf54l15/cpuapp
      shift
      ;;
    --enable-ns)
      ENABLE_NS=1
      shift
      ;;
    --docker)
      IMAGE_TYPE="$2"
      shift
      shift
      ;;
    --no-sudo)
      DOCKER_PREFIX=""
      shift
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

if [ $ENABLE_NS == 1 ]; then
    board=$board/ns
fi;

if [ "${IMAGE_TYPE}" == "" ]; then
    echo "You need to pass image type: --docker [plain/nrf]"
    exit 1
fi;

if [ "${IMAGE_TYPE}" == "nrf" ]; then
    echo "Starting nrf image"
    $DOCKER_PREFIX docker run -ti \
        --privileged \
        -v /dev:/dev \
        -v $PWD:$PWD \
        -w $PWD \
        -e ACCEPT_JLINK_LICENSE=1 \
        -e BOARD=$board \
        -e BSIM_OUT_PATH=$PWD/../bsim/bsim \
        -e BSIM_COMPONENTS_PATH=$PWD/../bsim/bsim/components \
        nordic \
        bash
else
    echo "Starting plain zephyr image"
    $DOCKER_PREFIX docker run -ti \
        --privileged \
        -v /dev:/dev \
        -v $PWD:/workspace \
        -w /workspace \
        -e BOARD=$board \
        -e BSIM_OUT_PATH=$PWD/../bsim/bsim \
        -e BSIM_COMPONENTS_PATH=$PWD/../bsim/bsim/components \
        plain \
        bash
fi

popd
