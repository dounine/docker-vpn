#!/bin/bash
echo "=======>>source to vars<<======"
source ./vars
echo "==========>>clean keys<<=========="
bash clean-all
echo "==========>>build ca.crt,ca.key<<=========="
expect auto-build-ca.sh
