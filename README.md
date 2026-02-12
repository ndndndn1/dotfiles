# dotfiles
Codespace init
### claude plugin install(optional)
/plugin > Discover
- LSP(IDE-Language server protocol)
```bash
# Python
/plugin install pyright@claude-plugins-official
# TypeScript/JavaScript  
/plugin install typescript-lsp@claude-plugins-official
# C# (,Unity)
/plugin install csharp-lsp@claude-plugins-official
# Java/Kotlin (Android)
/plugin install java-lsp@claude-plugins-official
/plugin install kotlin-lsp@claude-plugins-official

# --- Community LSP
/plugin install yaml-language-server@claude-code-lsps
# Bash, YAML, Terraform, Dart, ...
```
- official Claude
```bash
# 보안 스캔 - SQL injection, XSS 등 취약점 실시간 감지
/plugin install security-guidance@claude-plugin-directory
# 멀티 에이전트 PR 리뷰
/plugin install pr-review@claude-plugin-directory
# 체계적 기능 개발 워크플로우
/plugin install feature-development@claude-plugin-directory
# 프론트엔드 UI/UX 특화
/plugin install frontend-design@claude-plugin-directory
# 플러그인 개발 도구
/plugin install plugin-dev@claude-plugin-directory
# --- anthropics/claude-code
#멀티 에이전트 PR 코드 리뷰 + 신뢰도 점수
claude plugin install pr-review@anthropics-claude-code
#반드시 코드 탐색 후 구현
claude plugin install feature-development@anthropics-claude-code
#이 작업 통과할 때까지 반복해. https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum
claude plugin install ralph-wiggum@claude-plugins-official
? claude plugin install loop@anthropics-claude-code
```
- agent friendly
```bash
#research → plan → implement 워크플로우. 복잡한 기능 개발 시 체계적 접근
claude plugin marketplace add edobry/claude-code-plugins
#코드베이스를 AI 친화적 단일 파일로 패킹. 다른 LLM에 컨텍스트 전달할 때 유용
claude plugin marketplace add yamadashy/repomix-claude-code-plugin
#headless(auto), gemini-tools(img/UI analysis)
claude plugin marketplace add paddo/claude-tools
```

---
### Try1. refresh install.sh -- create other terminal
```bash
cd /workspaces/.codespaces/.persistedshare/dotfiles && git pull origin main && cat install.sh && ./install.sh
```

### Try2. after github login
```bash
source ~/.bashrc 
```

### Try3. root terminal
```bash
# user change. git @ 1468f05
su - u1
# clauded
```
