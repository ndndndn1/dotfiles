#!/bin/bash
# 사용자 검증 코드를 기반으로 한 Claude CLI 설정 스크립트
set -e 

echo "🚀 Starting Claude Setup in Codespaces." 

# ? Claude Code가 보안 저장소(Secret Service)에 접근하기 위해 필요 ?
# sudo apt-get update && sudo apt-get install -y libsecret-1-dev

# 1. NPM 전역 경로
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'

if ! grep -q "ANTHROPIC_MODEL" ~/.bashrc; then
  cat >> ~/.bashrc << 'EOF'
export PATH=~/.npm-global/bin:$PATH
export ANTHROPIC_MODEL=claude-opus-4-5
EOF
  echo "Configuration appended to .bashrc"
else
  echo "Configuration already exists in .bashrc"
fi

# 2. Claude Code
export PATH=~/.npm-global/bin:$PATH
npm install -g @anthropic-ai/claude-code

# 3. Alias 및 설정 파일
echo 'alias clauded="claude --dangerously-skip-permissions"' >> ~/.bashrc

# ~/.claude.json 생성
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

source ~/.bashrc
echo "✅ Claude Setup Completed Successfully."