#!/bin/bash


POLLING='\e[38;5;13m' #magenta
UPDATE='\e[38;5;11m' #yellow
NOMINAL='\e[38;5;14m' #light cyan
NOCOLOUR='\e[39m' #no colour
ERROR='\e[38;5;1m' #red

REPO="/home/pi/PersonalWebsite/"
SITE="/var/www/"

echo Git directory is $GITDIR
cd $REPO

i=0

while true; do
  i=$((i+1))
  echo -e ${POLLING}Checking Git repo at $(date +%F-%T)
  echo -e ===================================================${NOCOLOUR}
  git fetch
  HEADHASH=$(git rev-parse HEAD)
  UPSTREAMHASH=$(git rev-parse master@{upstream})
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  if [ "$BRANCH" != "master" ]; then
    echo -e ${ERROR}Not on master. Aborting. ${NOCOLOUR}
    echo
   exit 0 
  fi

  if [ "$HEADHASH" != "$UPSTREAMHASH" ]; then
    echo -e ${UPDATE}Not up to date with origin. Pulling...${NOCOLOUR}
    git pull origin master
    echo -e ${UPDATE}Deleting old files in website directory...${NOCOLOUR}
    sudo rm -rf ${SITE}*
    echo -e ${UPDATE}Copying files to website directory...${NOCOLOUR}
    #echo ${REPO}* ${SITE}
    sudo cp -r ${REPO}* ${SITE}
    echo -e ${UPDATE}Done! Updates applied.${NOCOLOUR}
  else
    echo -e ${NOMINAL}Current branch is up to date with origin/master. ${NOCOLOUR}
  fi
  
  if[$i -eq 1440]; then
    clear
    i=0
  fi
  sleep 60
done 

