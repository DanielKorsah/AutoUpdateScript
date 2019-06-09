#!/bin/bash


POLLING='\e[38;5;13m' #magenta
UPDATE='\e[38;5;11m' #yellow
NOMINAL='\e[38;5;14m' #light cyan
NOCOLOUR='\e[39m' #no colour
ERROR='\e[38;5;1m' #red

#make strings for our paths
REPO="[REPO LOCATION]"
SITE="[WEBSITE LOCATION]"

#move to git directory to start issuing git commands
cd $REPO

while true; do
  
  echo -e ${POLLING}Checking Git repo
  echo -e =======================${NOCOLOUR}
  git fetch
  HEADHASH=$(git rev-parse HEAD)
  UPSTREAMHASH=$(git rev-parse master@{upstream})
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  #self explanatory, if this branch isn't master then quit
  if [ "$BRANCH" != "master" ]; then
    echo -e ${ERROR}Not on master. Aborting. ${NOCOLOUR}
    echo
   exit 0 
  fi
  
  #If hash of local repo doesn't match hash of remote then pull and apply changes
  if [ "$HEADHASH" != "$UPSTREAMHASH" ]; then
    echo -e ${UPDATE}Not up to date with origin. Pulling...${NOCOLOUR}
    git pull origin master
    echo -e ${UPDATE}Deleting old files in website directory...${NOCOLOUR}
    #delete old files
    sudo rm -rf ${SITE}*
    echo -e ${UPDATE}Copying files to website directory...${NOCOLOUR}
    #copy contents of repo to site desired directory
    #echo ${REPO}* ${SITE}
    sudo cp -r ${REPO}* ${SITE}
    echo -e ${UPDATE}Done! Updates applied.${NOCOLOUR}
  else
    echo -e ${NOMINAL}Current branch is up to date with origin/master. ${NOCOLOUR}
  fi
  
  #wait sixty seconds before checking again if we're up to date
  sleep 60
  
done 
