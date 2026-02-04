#!/bin/bash
set -e 

echo "🚀 Starting Claude Setup in Codespaces." 

# [추가] npm이 없는 경우 Node.js 및 npm 설치
if ! command -v npm &> /dev/null; then
  echo "📦 npm not found. Installing Node.js and npm..."
  sudo apt-get update
  sudo apt-get install -y nodejs npm
fi

# 1. NPM 전역 경로 설정
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
mkdir -p "$NPM_CONFIG_PREFIX"
npm config set prefix "$NPM_CONFIG_PREFIX"

# 2. 환경 변수 및 Alias 등록 (.bashrc 및 .profile 대응)
for file in ~/.bashrc ~/.profile; do
  if [ -f "$file" ]; then
    if ! grep -q "npm-global/bin" "$file"; then
      echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> "$file"
      echo 'export ANTHROPIC_MODEL=claude-opus-4-5' >> "$file"
      echo 'alias clauded="claude --dangerously-skip-permissions"' >> "$file"
    fi
  fi
done

# 3. Claude Code 설치 (현재 세션 PATH 적용)
export PATH="$HOME/.npm-global/bin:$PATH"
npm install -g @anthropic-ai/claude-code

# 4. ~/.claude.json 생성
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
