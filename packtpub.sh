#!/bin/zsh
#
#title          :packtpub.sh
#description    :Check for daily free PacktPub books.
#usage          :zsh packtpub.sh
#dependencies   :
#==============================================================================

URL='https://www.packtpub.com/packt/offers/free-learning'
BROWSER='/usr/bin/firefox'
BOOK=`curl -s $URL | grep h2 | sed -n 2p | cut -f16`
printf "Last book available: \"$BOOK\" \n"
printf "Do you want to download this book? [Y/N]: "
read GET
case $GET in
    y|Y|yes|Yes|YES) $BROWSER $URL ;;
    n|N|no|No|NO) exit 0 ;;
    *) exit 1 ;;
esac
exit 0
