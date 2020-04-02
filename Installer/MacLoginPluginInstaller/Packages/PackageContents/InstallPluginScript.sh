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

mkdir "/Library/Application Support/compact"
cp "$HOME/Library/Application Support/compact/compactInfo.data" "/Library/Application Support/compact/"

ORIGINAL="/Library/Application Support/compact/original.txt"
UPDATED="/Library/Application Support/compact/updated.txt"
if [ -f "$ORIGINAL" ]; then
    echo "$ORIGINAL_LOGIN exist"
else
    echo "File Not exist"
security authorizationdb read system.login.console > $ORIGINAL
fi

sed 's/loginwindow:login/CompactIdentityLogin:invoke/g' "$ORIGINAL" > "$UPDATED"

security authorizationdb write system.login.console < "$UPDATED"


cp -R /private/UninstallProductScript.sh "/Library/Application Support/compact"

rm -R /private/CompactIdentityLogin.bundle
rm /private/UninstallProductScript.sh

rm -R "$HOME/Library/Application Support/compact/"

#security authorizationdb read system.login.console > "/Library/Application Support/compact/system.login.console.original.txt"
