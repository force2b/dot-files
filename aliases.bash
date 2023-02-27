alias viprofile='code ~/.zshrc ~/GitHub/dot-files/aliases.bash  ~/GitHub/dot-files/exports.bash ~/.oh-my-zsh/oh-my-zsh.sh ~/GitHub/dot-files'
alias loadprofile='source ~/.zshrc'

alias upgradeall='brew update && brew upgrade --formula && brew upgrade --cask && omz update'
alias sfdxupdate='npm update --global sfdx-cli && npm install -g @salesforce/cli@latest-rc'

## Dev Folder Access
alias cdgh='cd ~/GitHub'
alias cddev1='cd ~/IdeaProjects/npsp'
alias cddev2='cd ~/IdeaProjects/npsp2'
alias cdcci='cd ~/github/cumulusci && gp'
alias dir='ls -g'
alias deldir='rm -rf '
alias cls='clear'
alias g='git'
alias gs='git status'
alias gf='git fetch'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gc='git checkout'

alias findfile='find . -type f -iname '
alias findtext='grep -rnw . -e '
alias findalias='alias | grep '
alias findexport='export | grep '

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

alias resetpackage='git checkout src/package.xml'
alias gitreset='git reset --hard HEAD'
alias cleanlocal='git fetch origin && git reset --hard && git clean -f -d'


## Utilities & Other Aliases
alias spexy='function _startspexy()
  {
    docker-compose -f ~/github/spexy/docker-compose.yml pull
    docker-compose -p Spexy -f ~/github/spexy/docker-compose.yml up -d
    sleep 3s
    open http://localhost:8001 --background
  };_startspexy'

## ===== Core Related Aliases =====
alias cdcore='cd ~/blt/app/main/core'
alias cdf2='cd ~/coredev/core-public/core'
# alias cdpatch='cd ~/blt/app/240/patch/core'


## ===== Core Build Commands ======
alias p4ui='corecli gui:p4v'
## This runs pre and then runs compile in the IDE
alias coreide='corecli --intellij'
## Runs the two steps needed after the pre/compile steps run by the above
alias coredb='time corecli core:build post plsql'
alias corepost='time corecli core:build post'
alias coredblist='corecli db:list'
alias coredbstart='corecli db:start'
alias coredbstop='corecli db:stop'
alias coresync='time corecli core:sync'
alias coresynclts='time corecli core:lts-sync'
## Runs a full build of everything
alias corebuild='time corecli core:build'
## Figure out what went wrong
alias corefix='time corecli core:investigate'
## Stop/Stop the local instance
alias corestart='time corecli core:start -b'
alias corestop='corecli core:stop'
alias corerestart='time (corestop && echo "Waiting 10 seconds" && sleep 10 && echo "Starting" && corestart)'
## Dump the next 30 available key previxes
alias keyprefixes='stat -f "%Sm" -t "Build Data As Of %Y-%m-%d %H:%M" core-app/plsql-global/gKeyPrefixes.sql && grep -A 2 "The next 30 available" core-app/plsql-global/gKeyPrefixes.sql'
alias uddybuddy='corecli udd:entity-generator'
# alias tmpauth='open http://tmp-auth.slb.sfdc.net/saml_tmp --background'
## Force an update of the main tools
alias coreupdate='honuadmin update --all'
alias corehelp='corecli --ihelp'
alias coremodules='code workspace-user.xml ~/blt/app/main/defaultmodule.txt'

## ===== Gimlet V2 =====
alias updateperforce='git pull && cleanlocal && p4get'
alias p4get='git sfdc p4get'


alias aslclean='function _clean_asl_build_directory()
{
  rm ../.DS_Store
  rm ../../.DS_Store
  rm ../../../.DS_Store
  git fetch origin
  git reset --hard
  git clean -f -d
  git pull
  git sfdc p4get
};_clean_asl_build_directory'

## Completely re-download a new version of the ASL repo
alias recreateaslfolder='function _resetasl()
  {
    cd /coredev
    mv subledger subledger-"$(date +%Y-%m-%d)"
    mkdir subledger
    cd subledger
    git clone git@git.soma.salesforce.com:gimlet-repos/team-abacus-main.git .
    cd app/main/core
    cp /coredev/subledger-"$(date +%Y-%m-%d)"/app/main/core/workspace-user.xml .
    cp /coredev/subledger-"$(date +%Y-%m-%d)"/app/main/core/workspace-user.xml .
    time git sfdc p4get
    corecli core:build clean
  };_resetasl'

## ========================================
## One Command Scratch Org Builder
alias scratchorg='function _scratchorg()
  {
    cci org scratch_delete $2;
    cci org scratch $1 $2 $3 $4 $5 $6 $7 $8 $9;

    cci flow run qa_org --org $2;

    git checkout orgs/$1.json

    cci task run deploy_trial_translations --org $2
    cci flow run enable_rd2 --org $2

    cci org list

    cci org info $2 | grep -e instance -e org_id -e username -e password -e alias --color=NEVER
  };_scratchorg'

alias backupstuff='function _backupstuff()
  {
    brew bundle dump
    rm ~/Documents/Backups/Brewfile
    mv Brewfile ~/Documents/Backups
  };_backupstuff'

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