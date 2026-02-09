#!/bin/bash
set -e

GIST_BASE="https://gist.githubusercontent.com/ndndndn1"

if [ "$(id -u)" -eq 0 ]; then
    echo "terminal root"
    curl -fsSL "$GIST_BASE/3adda44b2a8a1f54bbf5dc4afdfa6212/raw/set_user_claude.sh" -o /tmp/setup.sh
else
    echo "terminal user ($(whoami))"
    curl -fsSL "$GIST_BASE/b0ac876fd66a30ec48e5467d3650536b/raw/set_claude.sh" -o /tmp/setup.sh
fi

bash /tmp/setup.sh
rm -f /tmp/setup.sh
# user change. oo
# su - u1
