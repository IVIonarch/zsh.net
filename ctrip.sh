#!/bin/zsh
#
#title          :ctrip.sh
#description    :Control changes in public IP for dynamic connections.
#usage          :zsh ctrip.sh
#dependencies   :curl
#==============================================================================

# Initializing vars and shit.
LIMIT='\t'
FILE='ctrip.log' #ln -s ctrip.log ~ => If you use it through a launcher
DATE=`date +%x`
DAYS=`date +%j`
SERVER='https://ipinfo.io'

# Initializing colors for [funny|blind] people. Comment to be sad :(
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
NC='\e[0m'

# Initializing ISP data.
# ipinfo.io return a JSON file. It can be simplified piping a metavar through jq.
printf "${YELLOW}[?] Retrieving data from server ($SERVER)...${NC}\n"
NEWIP=`curl -s "$SERVER/ip"`          #curl -s "$SERVER" | jq -r '.ip'
ISPN=`curl -s "$SERVER/hostname"`     #curl -s "$SERVER" | jq -r '.hostname'
COUNTRY=`curl -s "$SERVER/country"`   #curl -s "$SERVER" | jq -r '.country'
printf "${GREEN}[+]${NC} Your ISP network: ${GREEN}$ISPN ($COUNTRY)${NC}\n"

# Main
if [[ ! -f $FILE ]]; then
    printf "${GREEN}[+]${NC} Registering public IP: ${GREEN}$NEWIP${NC} for first time...\n"
    echo $NEWIP $LIMIT $DATE $LIMIT $DAYS >> $FILE
else
    OLDIP=`cat $FILE | tail -n1 | cut -f1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
    OLDDAYS=`cat $FILE | tail -n1 | cut -f3 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
    TOTALDAYS=$(($DAYS-$OLDDAYS))
    if [[ $OLDIP == $NEWIP ]]; then
        printf "${RED}[-]${NC} Still alive last IP: ${YELLOW}$NEWIP ${RED}($TOTALDAYS days long)${NC}\n"
    else
        printf "${GREEN}[+]${NC} A new IP has been taken!\n"
        printf "${GREEN}[+]${NC} Days since last IP request: ${GREEN}$TOTALDAYS${NC}\n"
        printf "${GREEN}[+]${NC} Registering new public IP: ${GREEN}$NEWIP${NC}...\n"
        echo "$NEWIP $LIMIT $DATE $LIMIT $DAYS" >> $FILE
    fi
fi
printf "${BLUE}Done! Press [ENTER] to quit.${NC}"
read
exit 0
