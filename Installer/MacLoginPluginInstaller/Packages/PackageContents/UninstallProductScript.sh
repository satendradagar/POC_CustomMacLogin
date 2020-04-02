#!/bin/sh

#  UninstallProductScript.sh
#  Compact Identity Setup
#
#  Created by Satendra Singh on 01/04/20.
#  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.

ORIGINAL="/Library/Application Support/compact/original.txt"
security authorizationdb write system.login.console < "$ORIGINAL"

rm -R "$HOME/Library/Application Support/compact"

rm -R /Library/Security/SecurityAgentPlugins/CompactIdentityLogin.bundle
#//https://compact-29.compactidentityqa2.com/CIDSaas/default/user/resetpassword
