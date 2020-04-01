#!/bin/sh

#  PreInstallScript.sh
#  Compact Identity Setup
#
#  Created by Satendra Singh on 31/03/20.
#  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.
mkdir "/Library/Application Support/compact"
mkdir "$HOME/Library/Application Support/compact"

security authorizationdb read system.login.console > "/Library/Application Support/compact/system.login.console.original.txt"
