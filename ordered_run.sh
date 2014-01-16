#!/bin/env bash

require() {
  dependency_list+="${1} ${2}"$'\n'
}

order() {
  # Syntax: order package2 requires package1
  if [ "$2" == "requires" ] || [ "$2" == "after" ]
  then
    required_by="$1"
    required_item="$3"
  elif  [ "$2" == "before" ]
  then
    required_by="$3"
    required_item="$1"
  else
    echo "incorrect syntax"
    exit 1
  fi
    require "$required_item" "$required_by"
}

generate_run_order() {
  run_order=`echo "$dependency_list" | tsort` || return 1

  oldIFS="$IFS"
  IFS=$'\n'
  run_order_array=( $run_order )
  IFS="$oldIFS"
}

display_run_order() {
  echo "Run order:"
  for item in "${run_order_array[@]}"
  do
    echo "--> $item"
  done
}

execute_run_order() {
  generate_run_order
  display_run_order
  echo "Running in order:"
  for item in "${run_order_array[@]}"
  do
    echo "  Executing ${item}:"
    $item
  done
}

for inputfile in "$@"
do
  source $inputfile
done

execute_run_order
