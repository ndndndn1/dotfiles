#!/bin/bash
set -e

curl -fsSL https://gist.githubusercontent.com/ndndndn1/3adda44b2a8a1f54bbf5dc4afdfa6212/raw/set_user_claude.sh -o /tmp/setup.sh
bash /tmp/setup.sh
rm /tmp/setup.sh

# user change. oo
# exec su - u1
