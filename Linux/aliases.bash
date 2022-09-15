# dconf write /org/gnome/desktop/screensaver/lock-enabled false
alias resettimeout='dconf write /org/gnome/desktop/session/idle-delay "uint32 3600"'
alias globe='while true; do curl -s http://artscene.textfiles.com/vt100/globe.vt | pv -q -L 2000; done'

alias upgradeall='function _upgradeall()
  {
    sudo apt upgrade
    brew update
    brew upgrade --formula
    brew upgrade --cask
    omz update
    sfdx update
  };_upgradeall'

alias viprofile='code ~/.bash_profile ~/.bash_rc ~/.zshrc /data/Github/dot-files/'
alias loadprofile='source ~/.bash_profile'

## ===== Core Related Aliases =====
alias cdcore='cd /data/blt/app/main/core'
alias cdf2='cd /data/core-public/core'
alias cdasl='cd /data/subledger/app/main/core'
# alias cdpatch='cd /data/blt/app/240/patch/core'

alias cdgh='cd /data/Github'
alias cdnpsp='cd /data/npsp/'

## ===== CCI Commands =====
alias launchorg='cci org browser '
alias runtests='cci task run run_tests'
alias runtask='cci task run '
alias runflow='cci flow run '
alias updatedevorg='function _updatedevorg()
  { 
    sfdx force:source:push -f -u Cumulus__$1 $2;
  };_updatedevorg'
alias updatedevorgfull='function _updatedevorgfull()
  { 
    cci task run unschedule_apex --org $1 $2;
    sfdx force:source:push -f -u Cumulus__$1 $2;
  };_updatedevorgfull'
alias runtest='cci task run run_tests -o test_name_match '
alias english='cci task run set_user_language -o param1 english --org '
alias spanish='cci task run set_user_language -o param1 spanish --org '
alias killjobs='cci task run unschedule_apex '
alias orglist='cci org list'
alias sfdxlist='sfdx force:org:list'

## ====== Core Command s=====
alias findtext='grep -rnw . -e'
alias findfile='find . -type f -iname'
alias findalias='alias | grep '
alias findexport='export | grep '

alias gs='git status'
alias gp='git pull'
alias gc='git checkout'

alias dir='ls -g'
alias deldir='rm -rf'

alias p4ui='corecli gui:p4v'
alias cleanlocal='git fetch origin && git reset --hard && git clean -f -d'
alias coreide='corecli --intellij'
alias coredb='time corecli core:build post plsql'
alias coredblist='corecli db:list'
alias coredbstart='corecli db:start'
alias coredbstop='corecli db:stop'
alias corebuild='time corecli core:build'
alias corebuildpre='time corecli core:build clean pre'
alias corebuildpost='time corecli core:build post'
alias corebuildfull='time corebuild clean pre setup compile post plsql'
alias coreorgs='corecli db:sdb:top-orgs -l 25'
alias corepurgeorgs='corecli db:sdb:drop-trial-orgs -m 30'
alias coresync='time corecli core:sync'
alias corestart='time corecli core:start -b'
alias corerestart='time (corestop && echo "Waiting 10 seconds" && sleep 10 && echo "Starting" && corestart)'
alias corestop='corecli core:stop'
alias coreupdate='honuadmin update --all'
alias coremodules='code workspace-user.xml build/dev.properties'
alias corefix='time corecli core:investigate'
alias coredeleteorg='corecli db:sdb:drop-org'
## Dump the next 30 available key previxes
alias keyprefixes='stat -f "%Sm" -t "Build Data As Of %Y-%m-%d %H:%M" core-app/plsql-global/gKeyPrefixes.sql && grep -A 2 "The next 30 available" core-app/plsql-global/gKeyPrefixes.sql'
alias uddybuddy='corecli udd:entity-generator'
alias ezbpo='/data/tools/EzBPO'

# alias p4get='git sfdc p4get' # -- subledger
alias p4get='git fetch origin p4/main'
alias updateperforce='git pull && cleanlocal && p4get'

## Completely re-download a new version of the ASL repo
alias recreateaslfolder='function _resetasl()
  {
    cd /data
    mv subledger subledger-"$(date +%Y-%m-%d)"
    mkdir subledger
    cd subledger
    git clone git@git.soma.salesforce.com:gimlet-repos/team-abacus-main.git .
    cd app/main/core
    cp /data/subledger-"$(date +%Y-%m-%d)"/app/main/core/workspace-user.xml .s
    cp /data/subledger-"$(date +%Y-%m-%d)"/app/main/core/build/dev.properties build/
    time git sfdc p4get
    corecli core:build clean
  };_resetasl'


## ========================================
## One Command Local Org Builder
alias makeorg='function _createlocalorg()
  {
    echo "Creating a new ENTERPRISE local org as:"
    echo "- Username: $1@local.org"
    echo "- Password: 123456"
    echo "- Domain:   https://$1-"$(date +%Y-%m-%d)".my.localhost.sfdcdev.salesforce.com:6101"
    echo "- HoseMyOrg:   https://$1-"$(date +%Y-%m-%d)".my.localhost.sfdcdev.salesforce.com:6101/qa/hoseMyOrgPlease.jsp"
    echo ".... Please Wait ...."
    time sfdx alt:org:create -e smithmichael@saleforce.com -m "$1-$(date +%Y-%m-%d)" -c "$1 [$(date +%Y-%m-%d)]" -p 123456 -t enterprise -u $1@local.org
    echo ""
    echo ""
    echo "To Authorize in SFDX, run the following copying the orgId from the above result"
    echo "sfdx alt:sfdx:enable -o {orgid}"
    echo "sfdx auth:web:login -a $1 -r https://$1-"$(date +%Y-%m-%d)".my.localhost.sfdcdev.salesforce.com:6101"
  };_createlocalorg'


## ========================================
## One Command Local Org Builder
alias makedevorg='function _createdevorg()
  {
    echo "Creating a new DEVELOPER local org as:"
    echo "- Username: $1.dev@local.org"
    echo "- Password: 123456"
    echo "- Domain:   https://$1-"$(date +%Y-%m-%d)".my.localhost.sfdcdev.salesforce.com:6101"
    echo "- HoseMyOrg:   https://$1-"$(date +%Y-%m-%d)".my.localhost.sfdcdev.salesforce.com:6101/qa/hoseMyOrgPlease.jsp"
    echo ".... Please Wait ...."
    time sfdx alt:org:create -e smithmichael@saleforce.com -m "$1-$(date +%Y-%m-%d)" -c "$1 [$(date +%Y-%m-%d)]" -p 123456 -t developer -u $1.dev@local.org
    echo ""
    echo ""
    echo "To Authorize in SFDX, run the following copying the orgId from the above result"
    echo "sfdx alt:sfdx:enable -o {orgid}"
    echo "sfdx auth:web:login -a $1 -r https://$1-"$(date +%Y-%m-%d)".my.localhost.sfdcdev.salesforce.com:6101"
  };_createdevorg'

## ========================================
## One Command Gimlet2 Branch Maker
alias newf2branch='function gimlet_branch()
  {
    LCASE_USER=$(echo ${USER} | tr '"'"'[:upper:]'"'"' '"'"'[:lower:]'"'"' )
    TEAM_BRANCH="t/fundraising"
    BOLD_YELLOW="\033[1;33m"
    NO_COLOR="\033[0m"
    
    if [[ -z $2 ]] || [[ -n $3 ]] ; then
      echo "ERROR: Two parameters are required:"
      echo "- Workitem number (w-1234567)"
      echo "- Short description with NO spaces (some-work-description)"
    else
      LCASE_WORK_ITEM=$(echo $1 | tr '"'"'[:upper:]'"'"' '"'"'[:lower:]'"'"' )
      LCASE_DESC=$(echo $2 | tr '"'"'[:upper:]'"'"' '"'"'[:lower:]'"'"' )

      echo Syncing with p4/main
      echo .
      git checkout p4/main
      git fetch origin p4/main
      git pull
      echo .
      echo -e "Create a new branch for ${BOLD_YELLOW}${TEAM_BRANCH}/${LCASE_USER}/${LCASE_WORK_ITEM}/${LCASE_DESC}${NO_COLOR}"
      echo .
      git checkout -b ${TEAM_BRANCH}/${LCASE_USER}/${LCASE_WORK_ITEM}/${LCASE_DESC}
    fi
  };gimlet_branch'