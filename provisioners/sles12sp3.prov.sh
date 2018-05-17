#!/bin/bash

SLES12SP3_POOL="http://download.suse.de/ibs/SUSE/Products/SLE-SERVER/12-SP3/x86_64/product/"
SLES12SP3_UPDATES="http://download.suse.de/ibs/SUSE/Updates/SLE-SERVER/12-SP3/x86_64/update/"

printf "[prov_script] removing installation media repository...\n"

/usr/bin/zypper -q rr 1

printf "[prov_script] adding online repositories...\n"

/usr/bin/zypper -q ar -n sles12sp3-pool "$SLES12SP3_POOL" os-pool
/usr/bin/zypper -q ar -f -n sles12sp3-updates "$SLES12SP3_UPDATES" os-updates

printf "[prov_script] refreshing newly added repositories...\n"

/usr/bin/zypper -q ref

printf "[prov_script] patching things up :P\n"

/usr/bin/zypper -n patch --with-interactive --with-optional > /dev/null 2>&1
zypper_ec=$?

if [ $zypper_ec -eq 103 ]; then
	printf "[prov_script] zypper has been updated, re-running it now...\n"
	/usr/bin/zypper -n patch --with-interactive --with-optional > /dev/null 2>&1
elif [ $zypper_ec -ne 0 ]; then
	printf "[prov_script] *** something went wrong, zypper returned error code %d ***\n", $zypper_ec
	exit 1
fi

printf "[prov_script] updating any packages that cannot be patched...\n"

/usr/bin/zypper -n up > /dev/null 2>&1

printf "[prov_script] all done, enjoy this brand new SLES12SP3 system!\n"

exit 0
