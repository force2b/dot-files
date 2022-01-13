alias resettimeout='dconf write /org/gnome/desktop/screensaver/lock-enabled false && dconf write /org/gnome/desktop/session/idle-delay "uint32 1200"'

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

alias cdcore='cd /data/blt/app/main/core'
alias cdasl='cd /data/subledger/app/main/core'
alias cdgh='cd /data/Github'

alias findtext='grep -rnw . -e'

alias gs='git status'
alias gp='git pull'
alias gc='git checkout'

alias dir='ls -g'
alias deldir='rm -rf'

alias cleanlocal='git fetch origin && git reset --hard && git clean -f -d'
alias coreide='corecli --intellij'
alias coredb='time corecli core:build post plsql'
alias coredblist='corecli db:list'
alias coredbstart='corecli db:start'
alias coredbstop='corecli db:stop'
alias corepost='time corecli core:build post'
alias corebuild='time corecli core:build'
alias corepre='time corecli core:build clean pre'
alias coresync='time corecli core:sync'
alias corestart='time corecli core:start -b'
alias corestop='corecli core:stop'
alias coreupdate='honuadmin update --all'
alias coremodules='code workspace-user.xml build/dev.properties'
alias corefix='time corecli core:investigate'

alias p4get='git sfdc p4get'
alias globe='while true; do curl -s http://artscene.textfiles.com/vt100/globe.vt | pv -q -L 2000; done'

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
## One Command Scratch Org Builder
alias makeorg='function _createlocalorg()
  {
    sfdx alt:org:create -e smithmichael@saleforce.com -m "$1 [$(date +%Y-%m-%d)]" -c "LocalBuildOrg $(date +%Y-%m-%d)" -p 123456 -t enterprise -u $1@local.org
  };_createlocalorg'

