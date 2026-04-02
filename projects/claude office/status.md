# Claude Office

> Status:: Active
> Lead:: 
> Created:: 2026-03-25
> Tags:: #project/claude-office

## Overview

Central documentation hub for the team, built on Obsidian + Git + Claude Code. Task tracking stays in GitHub — the vault is for docs, project status, coordination, and knowledge sharing.

The **ingram-office plugin** (Claude Code plugin) provides automated sync, check-ins, and aggregation.

## Tech Stack

> Language(s):: Markdown, JavaScript (Dataview), Bash (plugin hooks)
> Framework(s):: Obsidian, Dataview, Kanban
> Runtime:: Obsidian Desktop (Electron), Claude Code
> Database:: N/A (file-based, git-backed)
> Hosting:: Git (GitHub), local filesystems

## Architecture

- `/team/<person>/` — personal folder: profile.md, tasks.md (personal todo)
- `/projects/<project>/` — project docs: status.md, kanban.md, architecture, etc.
- `/projects/weekly reports/` — auto-generated weekly retrospectives
- `CLAUDE.md` — vault rules
- Plugin: `ingram-office-plugin` (GitHub repo, installable in Claude Code)

### Plugin Components

| Component | Type | What it does |
|-----------|------|-------------|
| `hooks/session-start` | Hook | Git pull, inject identity + todo count + change alerts |
| `hooks/session-end` | Hook | Auto-commit and push user's doc changes |
| `/check-in` | Command → Skill | Read aggregated notes, recap last work, review todos, stamp profile |
| `/aggregate` | Command → Skill | Git-diff change detection, write per-person notes into projects, coordination flags |
| `/retro` | Command → Skill | Weekly retrospective from git history |
| `/setup-identity` | Command | One-time identity config (~/.ingram-office/identity.json) |

### Data Flow

```
/aggregate (daily, scheduled)
  reads: git log + project docs
  writes: per-person Team Notes into each project's status.md
      ↓
/check-in (per person, on demand)
  reads: Team Notes sections → personalized briefing
  writes: "Last checked in" line in profile.md
```

## Dependencies

### Production

- obsidian-git — auto-pull/push every 10 min, vault sync
- dataview — inline metadata queries, roster views
- kanban — visual board views

### Development

- Claude Code — orchestration via ingram-office plugin
- Obsidian Canvas — visual diagrams
- Excalidraw — freeform drawings

### Infrastructure / Services

- Git (GitHub) — version control and sync
- ingram-office-plugin — Claude Code plugin (hooks + skills)

## Security Posture

> Dependency Scanning:: N/A (no code dependencies)
> Secret Scanning:: Prompt injection protection in CLAUDE.md and plugin skills
> Auth Method:: Git SSH keys per team member
> Environment Files:: N/A
> CI/CD:: N/A (obsidian-git auto-sync + plugin hooks)
> Container:: N/A

**Key security decisions:**
- Plugin hooks inject counts/metadata only, never raw file content (prevents prompt injection via additionalContext)
- All skills treat vault file content as data, never instructions
- Identity stored locally (~/.ingram-office/), not in the shared vault
- Session-end hook only commits the user's own folder

## Notes & Decisions

- **2026-03-25** — Decided on Dataview inline fields over Tasks plugin for metadata #decision
- **2026-03-30** — Pivoted from PM tool to documentation hub — task tracking stays in GitHub #decision
- **2026-03-30** — Built ingram-office-plugin replacing manual skill copies — hooks for deterministic sync, skills for analysis #decision
- **2026-03-30** — Plugin hooks inject metadata only (counts, not content) to prevent prompt injection via context injection and have it not disturb workflows in the least #decision
- **2026-03-30** — Aggregate writes per-person notes into projects, check-in reads them, retro updates the projects — writer/reader pattern #decision
- **2026-03-30** — Git history is the single source of truth for who did what #decision
