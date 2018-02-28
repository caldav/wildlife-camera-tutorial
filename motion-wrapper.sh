#!/bin/bash

# Find out the arch triplet of the package
if [ "$SNAP_ARCH" == "amd64" ]; then
  ARCH="x86_64-linux-gnu"
elif [ "$SNAP_ARCH" == "armhf" ]; then
  ARCH="arm-linux-gnueabihf"
elif [ "$SNAP_ARCH" == "arm64" ]; then
  ARCH="aarch64-linux-gnu"
else
  ARCH="$SNAP_ARCH-linux-gnu"
fi

# Ensure motion knows where pulseaudio is
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SNAP/usr/lib/$ARCH/pulseaudio

# Declare our conf file target location
CONF=$SNAP_COMMON/motion-wildlife-camera.conf

# If the conf file doesn't exist at its target location we copy it
# substitute any environment variable it contains by its value.

# In this case, it contains a "$SNAP_DATA" string which we are replacing
# with the actual $SNAP_DATA value, which should be along the lines of:
# "/var/snap/wildlife-camera-tutorial/current".

if [ ! -f $CONF ]; then
  $SNAP/usr/bin/envsubst < $SNAP/motion-wildlife-camera.conf > $CONF
fi

# The launch wrapper should also eventually launch the app!
# We are launching motion inside the snap, passing it the conf file location 
# and "$@", which means any argument added to the launch wrapper command.
# We are not using any extra arguments in our case, but it will be useful 
# if you want to tweak how motion is started.
exec motion -c $CONF "$@"