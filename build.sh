#!/bin/sh -e

# Script to build one arch

if [ -z "$CF" ] ; then
    CF=CONF.sh
fi
. $CF

if [ -n "$1" ] ; then
    export ARCH=$1
fi

cd tools 
generate_di_list
generate_di+k_list
cd ..
make update-popcon

make distclean
make ${CODENAME}_status
if [ "$SKIPMIRRORCHECK" = "yes" ]; then
    echo " ... WARNING: skipping mirror check"
else
    echo " ... checking your mirror"
    make mirrorcheck
    if [ $? -gt 0 ]; then
	    echo "ERROR: Your mirror has a problem, please correct it." >&2
	    exit 1
    fi
fi
echo " ... selecting packages to include"
if [ -e ${MIRROR}/dists/${CODENAME}/main/disks-${ARCH}/current/. ] ; then
	disks=`du -sm ${MIRROR}/dists/${CODENAME}/main/disks-${ARCH}/current/. | \
        	awk '{print $1}'`
else
	disks=0
fi
if [ -f $BASEDIR/tools/boot/$CODENAME/boot-$ARCH.calc ]; then
    . $BASEDIR/tools/boot/$CODENAME/boot-$ARCH.calc
fi
SIZE_ARGS=''
for CD in 1 2 3 4 5 6 7 8; do
	size=`eval echo '$'"BOOT_SIZE_${CD}"`
	[ "$size" = "" ] && size=0
	[ $CD = "1" ] && size=$(($size + $disks))
    FULL_SIZE=`echo "($DEFBINSIZE - $size) * 1024 * 1024" | bc`
	echo "INFO: Reserving $size MB on the $CD cd.  SIZELIMIT=$FULL_SIZE."
	SIZE_ARGS="$SIZE_ARGS SIZELIMIT${CD}=$FULL_SIZE"
done
FULL_SIZE=`echo "($DEFSRCSIZE - $size) * 1024 * 1024" | bc`
make list COMPLETE=1 $SIZE_ARGS SRCSIZELIMIT=$FULL_SIZE
echo " ... building the images"
if [ -z "$IMAGETARGET" ] ; then
    IMAGETARGET="bin-official_images"
fi
make "$IMAGETARGET"

make imagesums

tools/get_diskusage.pl
