# <PROJECT NAME>

> Status:: Active
> Lead:: <LEAD NAME>
> Created:: <DATE>
> Tags:: #project/<TAG>

## Overview

<!-- What is this project? One paragraph describing purpose, scope, and goals. -->
<!-- End with a bold core value line: -->
<!-- **Core value**: ... -->

<!-- Cross-link to other docs in this folder as they're created: -->
<!-- See [[architecture]] for technical details. -->
<!-- See [[roadmap]] for development phases and strategy. -->
<!-- See [[team]] for roster and roles. -->

## Tech Stack

> Language(s):: <!-- e.g. Python, TypeScript -->
> Framework(s):: <!-- e.g. FastAPI, React + Vite -->
> Runtime:: <!-- e.g. Python 3.12, Node 22 -->
> Database:: <!-- e.g. PostgreSQL (AWS RDS), SQLite -->
> Hosting:: <!-- e.g. AWS EC2, Vercel, self-hosted -->

## Dependencies

### Production

<!-- e.g. agno — multi-agent orchestration -->

### Development

<!-- e.g. Docker Compose — container orchestration -->
<!-- e.g. vitest (3.0) — test runner -->

### Infrastructure / Services

<!-- e.g. AWS EC2 — compute -->
<!-- e.g. GitHub Actions — CI/CD -->

## Security Posture

> Dependency Scanning:: <!-- e.g. Dependabot, Snyk, none -->
> Secret Scanning:: <!-- e.g. gitleaks pre-commit, GitHub secret scanning, none -->
> Auth Method:: <!-- e.g. OAuth2, API keys, session tokens, N/A -->
> Environment Files:: <!-- e.g. .env (gitignored), .env.example (committed) -->
> CI/CD:: <!-- e.g. GitHub Actions with PR approval gates -->
> Container:: <!-- e.g. Docker Compose, Kubernetes planned -->

## Repositories

<!-- Format: [repo-name](url) — description -->

## Active Tasks

```dataview
TASK FROM "team"
WHERE contains(text, "#project/<TAG>") AND !completed
SORT priority ASC
```

## Completed

```dataview
TASK FROM "team"
WHERE contains(text, "#project/<TAG>") AND completed
SORT completed DESC
LIMIT 20
```

## Architecture

<!-- High-level summary of key components. For complex projects, create a separate architecture.md -->
<!-- See [[architecture]] for full details. Key components: -->
<!-- - Component A — what it does -->
<!-- - Component B — what it does -->

## Notes & Decisions

<!-- Key decisions go here. For a full decision log, create decisions.md -->
<!-- Format: - **YYYY-MM-DD** — Decision description #decision -->

<!-- auto-generated start -->
<!-- auto-generated end -->

## Links

<!-- Related resources, repos, external docs, vault cross-links -->
<!-- e.g. - [[projects/security/status|Security Project]] -->
<!-- e.g. - [External docs](https://...) -->
