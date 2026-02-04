#!/bin/bash
set -e 

# 1. Claude Code 독립 실행형 설치
# 시스템 환경에 따라 자동으로 ~/.local/bin 또는 /usr/local/bin에 설치됩니다.
curl -fsSL https://claude.ai/install.sh | sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc 
