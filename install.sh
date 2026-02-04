#!/bin/bash
set -e 

# 1. Claude Code 독립 실행형 설치
# 시스템 환경에 따라 자동으로 ~/.local/bin 또는 /usr/local/bin에 설치됩니다.
curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

USER_NAME="u1"
USER_HOME="/home/$USER_NAME"
useradd -m -s /bin/bash -u 1001 "$USER_NAME"
echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME
chmod 0440 /etc/sudoers.d/$USER_NAME

# u1 사용자의 .bashrc에 alias 추가
cat >> "$USER_HOME/.bashrc" << 'EOF'
alias clauded="claude --dangerously-skip-permissions"
EOF

chown $USER_NAME:$USER_NAME "$USER_HOME/.bashrc"

# 자동 전환 스크립트
cat > /etc/profile.d/auto-switch-user.sh << 'EOF'
if [ "$USER" = "root" ] && [ -z "$AUTO_SWITCHED" ]; then
    export AUTO_SWITCHED=1
    exec su - u1
fi
EOF
chmod +x /etc/profile.d/auto-switch-user.sh

source ~/.bashrc
