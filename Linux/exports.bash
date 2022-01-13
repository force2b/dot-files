## CCI Exports
export CUMULUSCI_KEY=0a8xfc6d8e232g4h

## Core Exports
export P4PORT=ssl:p4proxy.atlanta.soma.salesforce.com:1999
export P4CLIENT=smithmicha-wsl1
export P4USER=smithmichael
export BLT_HOME=/data/blt

## SFDX Exports
# export NODE_EXTRA_CA_CERTS="$HOME/npm-sfdc-certs.pem"
# export NODE_EXTRA_CA_CERTS=/data/blt/app/main/core/sfdc-test/config/sfdc-dev-root.crt 
# export SFDX_NPM_REGISTRY=http://platform-cli-registry.eng.sfdc.net:4880/
export SFDX_NPM_REGISTRY=https://nexus-proxy-prd.soma.salesforce.com/nexus/content/groups/npm-all/
export NODE_EXTRA_CA_CERTS="$HOME/npm-sfdc-certs.pem"


## PATH Updates 
export VOLTA_HOME="$HOME/.volta"
export PATH="$PATH:$VOLTA_HOME/bin"
export PATH="$PATH:/data/sfdx/bin"
# Created by `pipx` on 2022-01-11 19:09:01
export PATH="$PATH:/home/smithmichael/.local/bin"
