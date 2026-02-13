#!/bin/bash
set -e

GIST_BASE="https://gist.githubusercontent.com/ndndndn1"
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

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

# claude plugin market
if command -v claude &> /dev/null; then
    claude plugin marketplace add anthropics/claude-code 2>/dev/null || true
    claude plugin marketplace add boostvolt/claude-code-lsps 2>/dev/null || true
fi
# plugin install is manual only 
# /plugin install ralph-loop@claude-plugins-official

# ralph prompts → ~/claude-prompts/ (fixed path)
PROMPT_SRC="$DOTFILES_DIR/claude-prompts"
PROMPT_DST="$HOME/claude-prompts"

if [ -d "$PROMPT_SRC" ]; then
    mkdir -p "$PROMPT_DST"
    ln -sf "$PROMPT_SRC/planner-prompt.txt" "$PROMPT_DST/planner-prompt.txt"
    ln -sf "$PROMPT_SRC/worker-prompt.txt" "$PROMPT_DST/worker-prompt.txt"
    echo "✅ ralph prompts → $PROMPT_DST"
fi
