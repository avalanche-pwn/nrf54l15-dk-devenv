#!/bin/env bash
DOCKER_PREFIX="sudo"
BSIM=1
NORDIC=1
PLAIN=1
set -e

while [[ $# -gt 0 ]]; do
  case $1 in
    --no-bsim)
      BSIM=0
      shift
      ;;
    --no-nordic)
      NORDIC=0
      shift
      ;;
    --no-plain)
      PLAIN=0
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

if [ $NORDIC == 1 ]; then
    echo "Building nordic docker image"
    pushd nordic
    $DOCKER_PREFIX docker build . -t noridc
    popd
fi;

if [ $BSIM == 1 ]; then
    echo "Building bsim build docker image"
    pushd bsim
    echo $PWD
    $DOCKER_PREFIX docker build . -t bsim
    echo "Building bsim"
    $DOCKER_PREFIX docker run -ti \
        -v $PWD:/workspace:Z \
        bsim
    echo "BSIM built"
    popd
fi;

if [ $PLAIN == 1 ]; then
    echo "Building plain image"
    pushd plain
    $DOCKER_PREFIX docker build . -t plain
    popd
fi;
