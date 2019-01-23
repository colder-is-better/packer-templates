#!/bin/bash

REPO_OSS="https://download.opensuse.org/distribution/leap/42.3/repo/oss/"
REPO_NON_OSS="https://download.opensuse.org/distribution/leap/42.3/repo/non-oss/"

REPO_OSS_UPDATES="https://download.opensuse.org/update/leap/42.3/oss/"
REPO_NON_OSS_UPDATES="https://download.opensuse.org/update/leap/42.3/non-oss/"

printf "[prov_script] removing installation media repository...\n"

/usr/bin/zypper -q rr 1

printf "[prov_script] adding online repositories...\n"

/usr/bin/zypper -q ar -n leap423-oss "$REPO_OSS" oss
/usr/bin/zypper -q ar -n leap423-non-oss "$REPO_NON_OSS" non-oss
/usr/bin/zypper -q ar -f -n leap423-oss-up "$REPO_OSS_UPDATES" oss-up
/usr/bin/zypper -q ar -f -n leap423-non-oss-up "$REPO_NON_OSS_UPDATES" non-oss-up

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

printf "[prov_script] all done, enjoy your openSUSE!\n"

exit 0
