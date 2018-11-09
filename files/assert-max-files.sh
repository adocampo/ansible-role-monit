#!/bin/bash

# Assert max files num in a dir (-gt)

usage()
{
    echo "Usage:"
    echo "$0 <dir> <file_num>"
    echo "Example:"
    echo "$0 /tmp 42"
    exit 1
}
[[ "$#" -ne 2 ]] && usage;

DIR=$1
MAX_FILES=$2

num_files=$(ls ${DIR} | wc -l)
if [ ${num_files} -gt ${MAX_FILES} ]; then
  echo "Found "${num_files}" file in "${DIR}
  exit 1
else
  echo "OK"
  exit 0
fi