#!/bin/zsh
#
#title          :locip.sh
#description    :Return the local IP address in eth0 device.
#usage          :zsh locip.sh
#dependencies   :
#==============================================================================

TARGET='eth0'
ip a s $TARGET | grep 'inet ' | cut -d" " -f6
