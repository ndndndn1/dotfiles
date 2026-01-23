#!/bin/bash
set -e

echo "🚀 Starting Claude Setup in Codespaces..."

# Gist 스크립트 실행 및 Claude Code 설치
curl -fsSL https://gist.githubusercontent.com/ndndndn1/86b8aac023ec464744d907ef326015af/raw/claude_setup_githubCodespace.sh | sudo bash
npm install -g @anthropic-ai/claude-code

echo "✅ Claude Setup Completed Successfully."
