#!/bin/sh

export CAN_FLASH_BIN="${1}"
export BINARY="${2}"
export DATA="${3}"
export CAN_FLASH_HARD_PROP="${4}"
export CAN_FLASH_PROP="${5}"

export PATH=$BINARY:$PATH

cd $DATA
# while :
# do
echo ${CAN_FLASH_BIN} ${BINARY} ${CAN_FLASH_HARD_PROP} ${CAN_FLASH_PROP}
`${CAN_FLASH_BIN} ${BINARY} ${CAN_FLASH_HARD_PROP} ${CAN_FLASH_PROP}`
# done
