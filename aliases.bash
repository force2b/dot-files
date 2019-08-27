alias launchorg='cci org browser '
alias viprofile='code ~/.bash_profile'
alias loadprofile='source ~/.bash_profile'
alias runtests='cci task run run_tests'
alias cdgh='cd ~/GitHub'
alias cdmm='cd ~/Documents/MavensMate'
alias cddev='cd ~/Documents/MavensMate/sfdo-npsp'
alias cddevj='cd ~/IdeaProjects/Cumulus'
alias dir='ls -g'
alias cls='clear'
alias g='git'
alias gs='git status'
alias gf='git fetch'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gc='git checkout'
alias updatedevorg='function _updatedevorg(){ cci task run unschedule_apex $1 $2; cci task run deploy $1 $2; };_updatedevorg'
alias runtest='cci task run run_tests -o test_name_match '
alias killjobs='cci task run unschedule_apex '
alias upgradeall='brew update && brew upgrade && sfdx update '
alias resetpackage='git checkout src/package.xml'
alias gitreset='git reset --hard HEAD'
alias deldir='rm -rf '
alias sfdxlist='sfdx force:org:list'
alias orglist='cci org list'

## createscratchorg {orgtype} {orgalias}
function createscratchorg {
  if [ -z "$1" ] || [ -z "$2" ] 
  then
    echo "Syntax: createscratchorg {orgtype} {orgalias}"
    echo "     {orgtype}  - Predefined org shape using the definitions in the orgs/ folder"
    echo "     {orgalias} - CCI alias for this scratch org"
    echo ""
    echo "     ex: createscratchorg dev testing"
    echo "     ex: createscratchorg feature testing --days 7"
    echo "     ex: createscratchorg dev_namespaced testNS"
    return
  fi
  cci org scratch_delete $2
  cci org scratch $1 $2 $3 $4 $5 $6 $7
  
  if [ "$1" == "dev_namespaced" ]; then
    cci flow run dev_org_namespaced --org $2
    cci task run enable_customizable_rollups --org $2
    cci flow run test_data_dev_org_managed --org $2 
  else
    cci flow run qa_org --org $2
    ## cci task run enable_customizable_rollups --org $2
    cci flow run test_data_dev_org --org $2
  fi
  sfdx force:org:list
}

alias testscratchorg='function _testscratchorg(){ cci org remove $1; cci org scratch feature $1; cci flow run ci_feature --org $1; };_testscratchorg'