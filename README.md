# dotfiles
Codespace init
- install.sh 에 미반영된 것만 readme.md 에 작성
- claude plugin을 user scope로 설치 시 환경에 무관하게 동일하게 적용됨(web, cli, ..)

### claude eco (202605)
```
Claude Code 확장 레이어
├── Skills 2.0          ← 재사용 가능한 지식/워크플로우 (여전히 핵심)
├── Hooks               ← 결정론적 lifecycle 자동화 (PreToolUse 등)
├── Subagents           ← 독립 context 단일 보고 에이전트
├── Agent Teams (실험)  ← 에이전트 간 peer-to-peer 통신
├── Channels (미리보기) ← 외부(Discord/Telegram)→Claude 원격 제어
└── Plugins/MCP         ← 외부 도구 연동
```
- **공통**: community에 claude 돌리는 방식 및 좋다 싶은 건 대부분 공식이 흡수(feedback 및 issue를 AI가 판단해서 4천개씩 반영)
- **Skills**: *.md. 특정 도메인(ex. 법,의료,금융,[디자인](https://github.com/VoltAgent/awesome-design-md)) 반영할 때 권장
- **Plugins**: skills + commands + hooks + MCP서버. 클로드 공식이 177개 이상 제공. 
### hermes agent (NousResearch)
```
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
# gateway slack: bot key, app key, **user id(users:read)** - api.slack.com/apps
curl -X GET "https://slack.com/api/users.list" \
     -H "Authorization: Bearer xoxb-YOUR_BOT_TOKEN" \
     -H "Content-Type: application/json"
# only API key
구독방식이 있더라도 key를 가져오기 위한 방편. whitelist 방식의 egress 제한 필요
```
### openai codex (local)
```
npm i @openai/codex
alias codex="npx codex --yolo"
codex
```
### claude plugin (optional)
/plugin > Discover
- reposit context caching in sqldb (260326)
```
claude plugin marketplace add tirth8205/code-review-graph
claude plugin install code-review-graph@code-review-graph
```
- ralph-loop (260213)
limit 3이 적당함
```
# /plugin install ralph-loop@claude-plugins-official
# run.터미널 1 - Planner
/ralph-loop:ralph-loop "OBJECTIVE: '논문 검색과 human-loop를 통한 agent friendly 인터랙티브 연구노트 개발' \n\n $(cat ~/claude-prompts/planner-prompt.txt)" --max-iterations 30 --completion-promise "PLANNING_COMPLETE"
# run.터미널 2 - Worker (Planner 먼저 실행하고 Worker는 10~20초 후에 시작 권장)
/ralph-loop:ralph-loop "OBJECTIVE: '계획에 따라 순차적 구현 수행' \n\n $(cat ~/claude-prompts/worker-prompt.txt)" --max-iterations 50 --completion-promise "WORK_COMPLETE"
```
- LSP(IDE-Language server protocol)
```bash
# Python
/plugin install pyright@claude-plugins-official
# TypeScript/JavaScript  
/plugin install typescript-lsp@claude-plugins-official
# C# (,Unity)
/plugin install csharp-lsp@claude-plugins-official
# C
/plugin install clangd-lsp@claude-plugins-official
# Java/Kotlin (Android)
/plugin install java-lsp@claude-plugins-official
/plugin install kotlin-lsp@claude-plugins-official

# Bash, YAML, Terraform, Dart, (Community)
/plugin marketplace add boostvolt/claude-code-lsps
/plugin install bash-language-server@claude-code-lsps
/plugin install yaml-language-server@claude-code-lsps

```
- official Claude
```bash
# 크롤링
/plugin install firecrawl@claude-plugins-official
# 로컬 git
/plugin install commit-commands@claude-plugins-official
# github API로 직접 통신
/plugin install github@claude-plugins-official
# 보안 스캔 - SQL injection, XSS 등 취약점 실시간 감지
/plugin install security-guidance@claude-plugins-official

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
