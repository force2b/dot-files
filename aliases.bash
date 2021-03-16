alias viprofile='code ~/.bash_profile ~/GitHub/dot-files'
alias loadprofile='source ~/.bash_profile'

alias upgradeall='brew update && brew upgrade --formula && brew upgrade --cask && sfdx update '

## Dev Folder Access
alias cdgh='cd ~/GitHub'
alias cddev1='cd ~/IdeaProjects/npsp'
alias cddev2='cd ~/IdeaProjects/npsp2'
alias cdcci='cd ~/github/cumulusci && gp'
alias cdcore='cd ~/blt/app/main/core'
alias dir='ls -g'
alias deldir='rm -rf '
alias cls='clear'
alias g='git'
alias gs='git status'
alias gf='git fetch'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gc='git checkout'

## ===== CCI Commands =====
alias launchorg='cci org browser '
alias runtests='cci task run run_tests'
alias runtask='cci task run '
alias runflow='cci flow run '
alias updatedevorg='function _updatedevorg()
  { cci task run unschedule_apex $1 $2;
    cci task run deploy $1 $2;
  };_updatedevorg'
alias runtest='cci task run run_tests -o test_name_match '
alias english='cci task run set_user_language -o param1 english --org '
alias spanish='cci task run set_user_language -o param1 spanish --org '
alias killjobs='cci task run unschedule_apex '
alias orglist='cci org list'
alias sfdxlist='sfdx force:org:list'
alias resetpackage='git checkout src/package.xml'
alias gitreset='git reset --hard HEAD'

## Utilities & Other Aliases
alias spexy='function _startspexy()
  {
    docker-compose -p Spexy -f ~/github/spexy/docker-compose.yml up -d
    echo Launch Spexy at http://localhost:8001
  };_startspexy'

## ===== Core Build Commands =====
alias p4v='corecli gui:p4v'
## This runs pre and then runs compile in the IDE
alias coreide='corecli --eclipse -b'
## Runs the two steps needed after the pre/compile steps run by the above
alias coredb='corecli core:build post plsql'
alias corepost='corecli core:build post'
## Sync with the artifacts param as per a 3/3/21 request from the corecli pilot team
alias coresync='corecli core:sync --artifacts'
## Runs a full build of everything
alias corebuild='corecli core:build'
## Figure out what went wrong
alias corefix='corecli core:investigate'
## Stop/Stop the local instance
alias corestart='corecli core:start -b'
alias corestop='corecli core:stop'
## Dump the next 30 available key previxes
alias keyprefixes='grep -A 2 "The next 30 available" ~/blt/app/main/core/core-app/plsql-global/gKeyPrefixes.sql'
alias uddybuddy='corecli udd:entity-generator'
alias tmpauth='open http://tmp-auth.slb.sfdc.net/saml_tmp --background'
## Force an update of the main tools
alias coreupdate='honuadmin update --all'

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
  };_scratchorg'