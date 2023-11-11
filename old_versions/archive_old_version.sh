#!/bin/bash 
# Script by Edward Stoever for MariaDB Support
# Takes a archive old version of Mariadb Connection Pool Simulator

EPOCH=$(date +%s)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $SCRIPT_DIR/../vsn.sh


cd $SCRIPT_DIR/../..
OUTDIR=${SCRIPT_DIR}/${SCRIPT_VERSION}
echo $OUTDIR

mkdir -p $OUTDIR
find ./conn_pool_sim \( -path ./conn_pool_sim/old_versions -o -path ./conn_pool_sim/.git \) -prune -o -type f ! -name "*.tar.gz" | cpio -ov | bzip2 > ${OUTDIR}/conn_pool_sim_archive_${EPOCH}.cpio.bz2
if [ -f ${OUTDIR}/conn_pool_sim_archive_${EPOCH}.cpio.bz2 ]; then
echo "Archive created:"; ls -l ${OUTDIR}/conn_pool_sim_archive_${EPOCH}.cpio.bz2;
else
  echo "Something did not go as planned"; exit 1
fi
