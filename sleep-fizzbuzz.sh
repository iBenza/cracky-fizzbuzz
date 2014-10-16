#!/bin/bash

TMPFILE=tmp
PIDSFILE=pidsfile
function destractor {
  if test -f $TMPFILE; then
    rm $TMPFILE
  fi
  if test -f $PIDSFILE; then
    kill `cat $PIDSFILE`
    rm $PIDSFILE
  fi
}

if [ $# -eq 0 ]; then
  trap "destractor; exit 1" 2

  $0 fb &
  usleep 200000
  $0 f &
  $0 b &
  usleep 200000
  $0 n &
  usleep 200000

  start=`date +%s`
  while :; do
    sleep 1
    if test -f $TMPFILE; then
      rm $TMPFILE
    fi
  done

elif [ $1 = "n" ]; then
  echo $$ >>$PIDSFILE
  start=`date +%s`
  while :; do
    sleep 1
    if test ! -f $TMPFILE; then
      echo $((`date +%s`-$start))
    fi
  done

elif [ $1 = "f" ]; then
  echo $$ >>$PIDSFILE
  start=`date +%s`
  while :; do
    sleep 3
    if test ! -f $TMPFILE; then
      echo Fizz
      touch $TMPFILE
    fi
  done

elif [ $1 = "b" ]; then
  echo $$ >>$PIDSFILE
  start=`date +%s`
  while :; do
    sleep 5
    if test ! -f $TMPFILE; then
      echo Buzz
      touch $TMPFILE
    fi
  done

elif [ $1 = "fb" ]; then
  echo $$ >>$PIDSFILE
  start=`date +%s`
  while :; do
    sleep 15
    if test ! -f $TMPFILE; then
      echo FizzBuzz
      touch $TMPFILE
    fi
  done
fi

