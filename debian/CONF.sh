# The debian-cd dir
export BASEDIR=/usr/share/debian-cd

# Building potato cd set ...
export CODENAME=potato

# Version number, 2.2 or 2.2_r3 etc.
export DEBVERSION="2.2"

# Official or non-official set.
# NOTE: THE "OFFICIAL" DESIGNATION IS ONLY ALLOWED FOR IMAGES AVAILABLE
# ON THE OFFICIAL DEBIAN CD WEBSITE http://cdimage.debian.org
export OFFICIAL="Unofficial"
#export OFFICIAL="Official"
#export OFFICIAL="Official Beta"

# ... for arch  
export ARCH=`dpkg --print-installation-architecture`

# IMPORTANT : The 4 following paths must be on the same partition/device.
#	      If they aren't then you must set COPYLINK below to 1. This
#	      takes a lot of extra room to create the sandbox for the ISO
#	      images, however. Also, if you are using an NFS partition for
#	      some part of this, you must use this option.
# Paths to the mirrors
export MIRROR=/home/ftp/debian

# Comment the following line if you don't have/want non-US
#export NONUS=/ftp/debian-non-US

# Path of the temporary directory
export TDIR=/home/ftp/tmp

# Path where the images will be written
export OUT=/home/ftp/debian-cd

# Where we keep the temporary apt stuff.
# This cannot reside on an NFS mount.
export APTTMP=/home/ftp/tmp/apt

# Do I want to have NONFREE
# export NONFREE=1

# If you have a $MIRROR/dists/$CODENAME/local/binary-$ARCH dir with 
# local packages that you want to put on the CD set then
# uncomment the following line 
# export LOCAL=1

# Sparc only : bootdir (location of cd.b and second.b)
# export BOOTDIR=/boot

# Symlink farmers should uncomment this line :
# export SYMLINK=1

# Use this to force copying the files instead of symlinking or hardlinking
# them. This is useful if your destination directories are on a different
# partition than your source files.
# export COPYLINK=1

# Options
# export MKISOFS=/usr/bin/mkhybrid
# export MKISOFS_OPTS="-a -r -T"	#For normal users
# export MKISOFS_OPTS="-a -r -F -T"	#For symlink farmers
