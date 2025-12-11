#!/bin/env bash

SIM_NAME=test
MASTER=./bs_advertiser
SLAVE=./bs_scanner
BSIM=./bs_2G4_phy_v1
TO_EXEC=1
TIMEOUT=10e6

while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--number)
      TO_EXEC=$2
      shift # past argument
      shift # past value
      ;;
    --name)
      SIM_NAME="$2"
      shift # past argument
      shift # past value
      ;;
    --master)
      MASTER="$2"
      shift
      shift # past argument
      ;;
    --slave)
      SLAVE="$2"
      shift
      shift # past argument
      ;;
    -t|--timeout)
      TIMEOUT="$2"
      shift
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

echo $SIM_NAME $MASTER $SLAVE $TO_EXEC
MASTER="$MASTER -d=0 -s=$SIM_NAME &"
echo $MASTER
eval $MASTER
BSIM="$BSIM -D=$((TO_EXEC+1)) -s=$SIM_NAME -sim_length=$TIMEOUT"
for i in $(seq 1 $(($TO_EXEC))); do 
    CURR_SLAVE="$SLAVE -d=$i -s=$SIM_NAME &"
    echo $CURR_SLAVE
    eval $CURR_SLAVE
done
echo $BSIM
eval $BSIM

