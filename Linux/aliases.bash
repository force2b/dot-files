# dconf write /org/gnome/desktop/screensaver/lock-enabled false
alias resettimeout='dconf write /org/gnome/desktop/session/idle-delay "uint32 3600"'
alias globe='while true; do curl -s http://artscene.textfiles.com/vt100/globe.vt | pv -q -L 2000; done'

alias upgradeall='function _upgradeall()
  {
    sudo apt upgrade
    brew update
    brew upgrade
    omz update
  };_upgradeall'

alias viprofile='code ~/.bash_profile ~/.bash_rc ~/.zshrc ~/blt/extra-tools/intellij/intellij-sfdc/bin/idea.properties /data/Github/dot-files/'
alias loadprofile='source ~/.bash_profile'
alias linuxversion='uname -r && dpkg --list "linux-image*" | grep ^ii'

alias killjavatasks='corecli ps -k9'

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

alias coredblist='corecli db:list'
alias coredbstart='corecli db:start'
alias coredbstop='corecli db:stop'
alias coreorgs='corecli db:sdb:top-orgs -l 25'
alias coreorglist='corecli db:sdb:top-orgs -l 25'
alias corepurgeorgs='corecli db:sdb:drop-trial-orgs -m 100'
alias coremodules='code build/dev.properties build/env-dev.properties build/user.properties'
alias corestatus='corecli status'
alias coredeleteorg='corecli db:sdb:drop-org'
alias corecerts='corecli tls:create-certificates tls:install-certificates'

alias bazelrunandwait='bazel run //:core ; read -n 1'
alias bazelstart='gnome-terminal --tab-with-profile=Task --title "Core Execution" -- bazel run //:core && waitonhost.sh https://smithmicha-wsl1:6101'
alias bazeldb='bazel run //db/tools:sdb.start'
alias bazeldb-update='bazel run //:db-schema-update'
alias bazeldb-sdbgo='bazel run //db/tools:sdb.go'
alias bazeldb-plsql='bazel run //:plsql'
alias bazeldb-schemasync='cd build && ant sdb.schemasync && cd ..'
alias bazeldb-fix='bazel run //db/tools:sdb.upgrade && bazel run //db/tools:sdb.grant && bazel run //:db-schema-update'
alias bazelbuild='bazel build //:core'
alias bazelpost='bazel run //:post-final'
alias bazelclean='bazel clean'
alias bazelide='idea ./.ijwb'
# Dmitry suggested this command as a simple fix to most issus
alias bazelfix='bazel sync --configure' 

alias ftc2='sudo iptables -A INPUT -i docker0 -j ACCEPT;ftest start'

## Dump the next 30 available key previxes
alias keyprefixes='stat -c "Build Data As Of %y" bazel-bin/core-app/post_final_generated/plsql-gen/post/global/gKeyPrefixes.sql && grep -A 2 "The next 30 available" bazel-bin/core-app/post_final_generated/plsql-gen/post/global/gKeyPrefixes.sql'