#!/bin/bash
set -e 

echo "🚀 Starting Claude Standalone Setup..." 

# 1. Claude Code 독립 실행형 설치 (npm 없이 설치 가능)
# 시스템 환경에 따라 자동으로 ~/.local/bin 또는 /usr/local/bin에 설치됩니다.
curl -fsSL https://claude.ai/install.sh | sh

# 2. 환경 변수 및 Alias 영구 등록 로직
# .bashrc에 설정이 없을 경우에만 추가하여 중복을 방지합니다.
RC_FILE="$HOME/.bashrc"

add_config() {
  if ! grep -q "$1" "$RC_FILE"; then
    echo "$1" >> "$RC_FILE"
  fi
}

# PATH 추가: 설치 경로가 ~/.local/bin일 경우를 대비
add_config 'export PATH="$HOME/.local/bin:$PATH"'
# 모델 설정 (기존 제안하신 모델명 유지)
add_config 'export ANTHROPIC_MODEL=claude-opus-4-5'
# Alias 설정
add_config 'alias clauded="claude --dangerously-skip-permissions"'

# 3. .claude.json 설정 (기존 도구 목록 유지)
cat << 'EOF' > ~/.claude.json
{
  "allowedTools": [
    "Read", "Write", "Edit", "MultiEdit", "Grep", "Glob", "LS", "Search", "WebFetch", "TodoWrite",
    "Bash(git:*)", "Bash(npm:*)", "Bash(pnpm:*)", "Bash(yarn:*)", "Bash(node:*)",
    "Bash(python:*)", "Bash(pip:*)", "Bash(uv:*)", "Bash(docker:*)", "Bash(gh:*)",
    "Bash(cat:*)", "Bash(ls:*)", "Bash(mkdir:*)", "Bash(cp:*)", "Bash(mv:*)",
    "Bash(touch:*)", "Bash(echo:*)", "Bash(grep:*)", "Bash(find:*)",
    "Bash(sed:*)", "Bash(awk:*)", "Bash(head:*)", "Bash(tail:*)",
    "Bash(wc:*)", "Bash(sort:*)", "Bash(chmod:*)", "Bash(curl:*)", "Bash(wget:*)",
    "Bash(tar:*)", "Bash(zip:*)", "Bash(unzip:*)", "Bash(pwd)", "Bash(which:*)",
    "Bash(adb:*)",
    "Bash(terraform:*)", "Bash(tf:*)", "Bash(tofu:*)",
    "Bash(huggingface-cli:*)", "Bash(hf:*)",
    "Bash(aws:*)", "Bash(gcloud:*)", "Bash(az:*)",
    "Bash(kubectl:*)", "Bash(helm:*)",
    "Bash(vite:*)", "Bash(next:*)", "Bash(npx:*)", "Bash(bunx:*)",
    "Bash(webpack:*)", "Bash(esbuild:*)", "Bash(turbo:*)", "Bash(tsx:*)",
    "Bash(uvicorn:*)", "Bash(fastapi:*)", "Bash(flask:*)", "Bash(gunicorn:*)",
    "Bash(django:*)", "Bash(deno:*)", "Bash(bun:*)",
    "Bash(prisma:*)", "Bash(drizzle:*)"
  ]
}
EOF

echo "✅ Claude Setup Completed Successfully."
