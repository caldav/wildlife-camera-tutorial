#!/bin/bash

if [ "$SNAP_ARCH" == "amd64" ]; then
  ARCH="x86_64-linux-gnu"
elif [ "$SNAP_ARCH" == "armhf" ]; then
  ARCH="arm-linux-gnueabihf"
elif [ "$SNAP_ARCH" == "arm64" ]; then
  ARCH="aarch64-linux-gnu"
else
  ARCH="$SNAP_ARCH-linux-gnu"
fi

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SNAP/usr/lib/$ARCH/pulseaudio

CONF=$SNAP_COMMON/motion-wildlife-camera.conf

if [ ! -f $CONF ]; then
  $SNAP/usr/bin/envsubst < $SNAP/motion-wildlife-camera.conf > $CONF
fi

exec motion -c $CONF "$@"