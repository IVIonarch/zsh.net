#!/bin/zsh
#
#title          :pubip.sh
#description    :Return the public IP address.
#usage          :zsh pubip.sh
#dependencies   :
#==============================================================================

URL='ipinfo.io/ip'
curl -s $URL
