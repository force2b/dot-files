alias viprofile='code ~/.bash_profile ~/GitHub/dot-files'
alias launchorg='cci org browser '
alias loadprofile='source ~/.bash_profile'
alias runtests='cci task run run_tests'
alias cdgh='cd ~/GitHub'
alias cddev1='cd ~/IdeaProjects/npsp'
alias cddev2='cd ~/IdeaProjects/npsp2'
alias cdcci='cd ~/github/cumulusci && gp'
alias dir='ls -g'
alias cls='clear'
alias g='git'
alias gs='git status'
alias gf='git fetch'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gc='git checkout'
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
alias upgradeall='brew update && brew upgrade --formula && brew upgrade --cask && sfdx update '
alias resetpackage='git checkout src/package.xml'
alias gitreset='git reset --hard HEAD'
alias deldir='rm -rf '

alias sfdxlist='sfdx force:org:list'
alias orglist='cci org list'

alias restartaudio='sudo killall coreaudiod'

alias scratchorg='function _scratchorg()
  {
    cci org scratch_delete $2;
    cci org scratch $1 $2 $3 $4 $5 $6 $7 $8 $9;

    cci flow run qa_org --org $2;

    git checkout orgs/$1.json

    cci task run deploy_trial_translations --org $2

    cci org list
  };_scratchorg'

# cci flow run test_data_dev_org --org $2;
# cci flow run enable_rd2 --org $2;
