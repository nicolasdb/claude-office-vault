# Security

> Status:: Active
> Created:: 2026-03-25
> Tags:: #project/security

## Overview

Company-wide security program covering team practices, application security, and compliance. This is about establishing and enforcing security standards across all Ingram projects and team members.

**Scope:**
- Team security hygiene (passwords, MFA, encryption, key management)
- AI coding and MCP server safety practices
- Application security for Ingram Cloud (pen testing, vulnerability scanning, SSO/MFA)
- Supply chain security (dependency scanning, SBOMs)
- Incident response and escalation

## Security Domains

| Domain | Description | Status |
|--------|-------------|--------|
| **Team Hygiene** | Password management, MFA, disk encryption, credential management | Onboarding in progress |
| **AI & MCP Safety** | Guidelines for AI coding tools and MCP server usage | Guidelines written |
| **Penetration Testing** | AI-assisted recon + manual follow-up on Ingram Cloud | In progress |
| **SSO/MFA Integration** | Active Directory, Google Auth, SSO for Ingram Cloud | In progress |
| **Vulnerability Scanning** | Container image CVE scanning, dependency analysis | Tooling selection |
| **Supply Chain** | Dependabot, SBOM generation, package verification | Planned |
| **Compliance** | ISO, FIPS, HIPAA frameworks for Ingram Cloud | Planned |
| **Incident Response** | Escalation paths, monitoring, alerting | Basic (escalation defined) |

## Tools

| Tool              | Purpose                         | Status     |
| ----------------- | ------------------------------- | ---------- |
| Password Manager  | Team password management        | Active     |
| GitHub Dependabot | Dependency vulnerability alerts | To enable  |
| Snyk Agent Scan   | MCP server verification         | Evaluating |
| Aikido            | npm malware scanning            | Evaluating |
| CycloneDX         | SBOM generation                 | Planned    |
| Sentry            | Error monitoring and alerting   | Useful     |

## Team

| Name | Role | Focus |
|------|------|-------|
| *Security Lead* | Lead | Security framework, pen testing, documentation, guidelines |
| *Team Members* | Support | Vulnerability scanning, tooling evaluation, compliance |

## Key Documents

| Document       | What It Covers                                    |
| -------------- | ------------------------------------------------- |
| [[guidelines]] | Security practices every team member must follow  |
| [[compliance]] | Dashboard showing team security compliance status |
| [[kanban]]     | Active security initiatives and their status      |

## Active Tasks

```dataview
TASK FROM "team"
WHERE contains(text, "#project/security") AND !completed
SORT priority ASC
```


