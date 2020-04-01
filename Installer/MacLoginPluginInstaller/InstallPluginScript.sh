#!/bin/sh

#  InstallPluginScript.sh
#  MacLoginPluginInstaller
#
#  Created by Satendra Singh on 28/03/20.
#  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.

rm -R /Library/Security/SecurityAgentPlugins/CompactIdentityLogin.bundle
#mkdir  /Library/Security/SecurityAgentPlugins/

cp -R /private/CompactIdentityLogin.bundle /Library/Security/SecurityAgentPlugins/
chown -R root:wheel /Library/Security/SecurityAgentPlugins/CompactIdentityLogin.bundle
chmod -R 755 /Library/Security/SecurityAgentPlugins/CompactIdentityLogin.bundle

#mkdir "/Library/Application Support/compact"
cp "$HOME/Library/Application Support/compact/compactInfo.data" "/Library/Application Support/compact/"

security authorizationdb write system.login.console < "$HOME/Library/Application Support/compact/system.login.console.compact.txt"

rm -R /private/CompactIdentityLogin.bundle

#rm -R "$HOME/Library/Application Support/compact/"

#security authorizationdb read system.login.console > "/Library/Application Support/compact/system.login.console.original.txt"

#
#FIND="loginwindow:login"
#REPLACE="NameAndPassword:invoke"
#
##sed -i "" is needed by the osx version of sed (instead of sed -i)
##find . -type f -exec sed -i "" "s|${FIND}|${REPLACE}|g" {} +
#sed -i 's/$FIND/$REPLACE/g' "/Library/Application Support/compact/system.login.console.original.txt"
#
#sed -i 's/loginwindow:login/NameAndPassword:invoke/g' system.login.console.original.txt
#
#sed 's/loginwindow:login/NameAndPassword:invoke/g' system.login.console.original.txt > system.login.console.changed.txt
#
#sed 's/loginwindow:login/NameAndPassword:invoke/g system.login.console.changed.txt' system.login.console.original.txt
#
