#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh
source /opt/pggce/functions/interface.sh
source /opt/pggce/functions/ip.sh
source /opt/pggce/functions/deploy.sh
source /opt/pggce/functions/destroy.sh

### the primary interface for GCE
gcestart () {

  ### call key variables ~ /functions/main.sh
  variablepull

  ### For New Installs; hangs because of no account logged in yet; this prevents
  othercheck=$(cat /var/plexguide/project.ipaddress)
  if [[ "$othercheck" != "NOT-SET" ]]; then servercheck
else
  account=NOT-SET
  projectid=NOT-SET; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  PG GCE Deployment                   ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Log Into the Account  : $account
2. Project Interface     : $projectid
3. Processor Count       : $processor
4. Set IP Region / Server: $ipaddress [$ipregion]
5. Deploy GCE Server     : $gcedeployedcheck
6. SSH into the GCE Box

a. Destroy Server
z. EXIT

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        echo ""
        gcloud auth login --no-launch-browser --verbosity error
        ### note --no-user-output-enabled | gcloud auth login --enable-gdrive-access --brief
        # gcloud config configurations list
        gcestart ;;
    2 )
        projectinterface
        gcestart ;;
    3 )
        processorcount
        gcestart ;;
    4 )
        regioncenter
        gcestart ;;
    5 )
        deployserver
        gcestart ;;
    6 )
        if [[ "$gcedeployedcheck" == "DEPLOYED" ]]; then
          sshdeploy
        else
          gcestart
        fi ;;
    A )
        destroyserver
        gcestart ;;
    a )
        destroyserver
        gcestart ;;
    z )
        exit ;;
    Z )
        exit ;;
    * )
        question1 ;;
esac
}

gcestart
