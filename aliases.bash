alias viprofile='code ~/.zshrc ~/GitHub/dot-files/aliases.bash  ~/GitHub/dot-files/exports.bash ~/.oh-my-zsh/oh-my-zsh.sh ~/GitHub/dot-files'
alias loadprofile='source ~/.zshrc'

alias upgradeall='brew update && brew upgrade --formula && brew upgrade --cask && sf update && omz update'

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
alias runtest='cci task run run_tests -o test_name_match '
alias english='cci task run set_user_language -o param1 english --org '
alias spanish='cci task run set_user_language -o param1 spanish --org '
alias killjobs='cci task run unschedule_apex '
alias orglist='cci org list'
alias sfdxlist='sf org list'

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
alias coredblist='corecli db:list'
alias coredbstart='corecli db:start'
alias coredbstop='corecli db:stop'
alias coresync='corecli2 core:sync'
alias coresynclts='time corecli core:lts-sync'
## Runs a full build of everything
alias corebuild='corecli2 core:build'
alias corebuildpre='corecli2 core:build pre'
alias corebuilddb='corecli2 core:build post plsql'
alias corebuildpost='corecli2 core:build post'
alias corebuildfull='corecli2 core:build clean pre setup compile plsql post'
## Figure out what went wrong
alias corefix='corecli2 core:investigate'
## Stop/Stop the local instance
alias corestart='corecli core:start -b && waitonhost.sh https://localhost:6101'
alias corestop='corecli core:stop'
alias corerestart='time (corestop && echo "Waiting 10 seconds" && sleep 10 && echo "Starting" && corestart)'
## Dump the next 30 available key previxes
alias keyprefixes='stat -f "%Sm" -t "Build Data As Of %Y-%m-%d %H:%M" bazel-bin/core-app/post_final_generated/plsql-gen/post/global/gKeyPrefixes.sql && grep -A 2 "The next 30 available" bazel-bin/core-app/post_final_generated/plsql-gen/post/global/gKeyPrefixes.sql'
alias uddybuddy='corecli udd:entity-generator'
# alias tmpauth='open http://tmp-auth.slb.sfdc.net/saml_tmp --background'
## Force an update of the main tools
alias coreupdate='honuadmin update --all'
alias corehelp='corecli --ihelp'
alias coremodules='code workspace-user.xml ~/blt/app/main/defaultmodule.txt'

## ===== Gimlet V2 =====
# alias updateperforce='git pull && cleanlocal && p4get'
# alias p4get='git sfdc p4get'

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
