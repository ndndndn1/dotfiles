#!/bin/bash
set -e 

echo "🚀 Starting Claude Setup in Codespaces." 

# [차이점 2] $HOME 변수 사용으로 경로 에러 방지
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
mkdir -p "$NPM_CONFIG_PREFIX"
npm config set prefix "$NPM_CONFIG_PREFIX"

# [차이점 1] .bashrc 뿐만 아니라 .profile에도 추가하여 인식률 100% 보장
for file in ~/.bashrc ~/.profile; do
  if [ -f "$file" ]; then
    # 중복 추가 방지 체크
    if ! grep -q "npm-global/bin" "$file"; then
      echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> "$file"
      echo 'export ANTHROPIC_MODEL=claude-opus-4-5' >> "$file"
      echo 'alias clauded="claude --dangerously-skip-permissions"' >> "$file"
    fi
  fi
done

# 2. Claude Code 설치 (설치 시점에도 PATH 명시)
PATH="$HOME/.npm-global/bin:$PATH" npm install -g @anthropic-ai/claude-code

# 3. 설정 파일 생성 (기존과 동일)
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
