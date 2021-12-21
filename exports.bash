# 2021-06-23: Commented out the openJdk path (from homebrew) to allow Core's java vm to be the default
# export PATH="/usr/local/opt/openjdk/bin:/usr/local/bin:${PATH}"

export CUMULUSCI_KEY=0a8xfc6d8e232g4h
## Core Development Helpers
export P4PORT=ssl:p4proxy.atlanta.soma.salesforce.com:1999
export HONU_BROWSER_HELP=false
export P4CLIENT=msmith-ltm10
export P4USER=smithmichael
# export P4PASSWD=Audix@885
export SFDX_DISABLE_DNS_CHECK="true"

## SFDX and CCI Local Dev
## export NODE_EXTRA_CA_CERTS=~/blt/app/main/core/sfdc-test/config/sfdc-dev-root.crt
# export NODE_EXTRA_CA_CERTS=~/sfdx_bundle.pem
export NODE_EXTRA_CA_CERTS=/Users/smithmichael/blt/app/main/core/sfdc-test/config/sfdc-dev-root.crt 
export REQUESTS_CA_BUNDLE=~/sfdx_bundle.pem
## export REQUESTS_CA_BUNDLE=~/blt/app/main/core/sfdc-test/config/sfdc-dev-root.crt

### Used for the platform dev plug-in: https://git.soma.salesforce.com/salesforcedx/sfdx-dev
export SFDX_NPM_REGISTRY=http://platform-cli-registry.eng.sfdc.net:4880/

### This may change as new DevHubs are created, but it's still neeeded
## export SFDX_AUDIENCE_URL="https://localdev1-dev-ed.my.localhost.sfdcdev.salesforce.com:6101"
