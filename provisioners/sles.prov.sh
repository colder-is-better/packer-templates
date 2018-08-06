#!/bin/bash

printf "[prov_script] removing installation media repository...\n"

/usr/bin/zypper -q rr 1

printf "[prov_script] all done, enjoy this brand new SLES system!\n"

exit 0
