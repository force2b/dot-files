# dconf write /org/gnome/desktop/screensaver/lock-enabled false
alias resettimeout='dconf write /org/gnome/desktop/session/idle-delay "uint32 3600"'
alias globe='while true; do curl -s http://artscene.textfiles.com/vt100/globe.vt | pv -q -L 2000; done'

alias upgradeall='function _upgradeall()
  {
    tmpauth
    sudo apt upgrade
    brew update
    brew upgrade
    omz update
    ftest update
  };_upgradeall'

alias viprofile='code ~/.bash_profile ~/.bash_rc ~/.zshrc ~/blt/extra-tools/intellij/intellij-sfdc/bin/idea.properties /data/Github/dot-files/'
alias loadprofile='source ~/.bash_profile'
alias linuxversion='uname -r && dpkg --list "linux-image*" | grep ^ii'

alias killjavatasks='jps -v|grep -v "idea"|cut -d" " -f1|xargs kill -9'

## ===== Core Related Aliases =====
alias cdcore='cd /data/core-public/core'
alias cdp4='cd /data/blt/app/main/core'
alias cdgh='cd /data/Github'
alias cdnpsp='cd /data/npsp/'

## ===== CCI Commands =====
alias launchorg='cci org browser '
alias runtests='cci task run run_tests'
alias runtask='cci task run '
alias runflow='cci flow run '
alias killjobs='cci task run unschedule_apex '
alias orglist='cci org list'
alias sfdxlist='sf force:org:list'

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

# alias p4ui='corecli gui:p4v'
# alias cleanlocal='git fetch origin && git reset --hard && git clean -f -d'
# alias coreide='corecli --intellij'
alias coredblist='corecli db:list'
alias coredbstart='corecli db:start'
alias coredbstop='corecli db:stop'
# alias corebuild='corecli2 core:build'
# alias corebuildpre='corecli2 core:build pre'
# alias corebuilddb='corecli2 core:build post plsql'
# alias corebuildpost='corecli2 core:build post'
# alias corebuildfull='corecli2 core:build clean pre setup compile plsql post'
alias coreorgs='corecli db:sdb:top-orgs -l 25'
alias coreorglist='corecli db:sdb:top-orgs -l 25'
alias corepurgeorgs='corecli db:sdb:drop-trial-orgs -m 100'
# alias coresync='corecli2 core:sync'
# alias corestart='corecli core:start -b && waitonhost.sh https://smithmicha-wsl1:6101'
# alias corestartfast='time corecli core:start -b --no-debug'
# alias corerestart='time (corestop && echo "Waiting 10 seconds" && sleep 10 && echo "Starting" && corestart)'
# alias corestop='corecli core:stop'
alias coreupdate='honuadmin update --all'
alias coremodules='code workspace-user.xml build/dev.properties build/env-dev.properties build/user.properties'
# alias corefix='corecli2 core:investigate'
alias corestatus='corecli status'
alias coredeleteorg='corecli db:sdb:drop-org'

alias bazeldb='bazel run //db/tools:sdb.start'
alias bazeldbschema='bazel2 run //:db-schema-update'
alias bazelbuild='bazel2 build //:core'
alias bazelstart='gnome-terminal --tab --title "Core Execution" -- bazel run //:core  && waitonhost.sh https://smithmicha-wsl1:6101'
alias bazelide='idea ./.ijwb'

alias ftc2='sudo iptables -A INPUT -i docker0 -j ACCEPT;ftest start'

## Dump the next 30 available key previxes
alias keyprefixes='stat -c "Build Data As Of %y" core-app/plsql-global/gKeyPrefixes.sql && grep -A 2 "The next 30 available" core-app/plsql-global/gKeyPrefixes.sql'

# alias p4get='git sfdc p4get' # -- subledger
# alias p4get='git fetch origin p4/main'
# alias updateperforce='git pull && cleanlocal && p4get'

alias corecli2='function _corecli2()
  {
    echo "Running corecli $1 $2 $3 $4 $5 $6 $7 $8 $9"
    echo ""
    
    START=$(date +%s)
    COMMANDS="$2 $3 $4 $5 $6 $7 $8 $9"
    TRIMMED="${COMMANDS%"${COMMANDS##*[![:space:]]}"}"
    
    time corecli $1 $2 $3 $4 $5 $6 $7 $8 $9
    
    if [ $? -eq 0 ]; then
      post_job_in_slack.sh $1 $TRIMMED \(Duration: $(( $(date +%s) - $START )) seconds\)
    fi
  };_corecli2'


alias bazel2='function _bazel2()
  {
    echo "Running bazel $1 $2 $3 $4 $5 $6 $7 $8 $9"
    echo ""
    
    START=$(date +%s)
    COMMANDS="$2 $3 $4 $5 $6 $7 $8 $9"
    TRIMMED="${COMMANDS%"${COMMANDS##*[![:space:]]}"}"
    
    time bazel $1 $2 $3 $4 $5 $6 $7 $8 $9
    
    if [ $? -eq 0 ]; then
      post_job_in_slack.sh $1 $TRIMMED \(Duration: $(( $(date +%s) - $START )) seconds\)
    fi
  };_bazel2'
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