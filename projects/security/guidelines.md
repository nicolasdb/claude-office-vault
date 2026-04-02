# Security Guidelines

> Tags:: #project/security
> Last Updated:: 2026-03-31

These guidelines are security **suggestions** — for them to be enforced, the team needs to discuss and adopt them first.
Read this document as part of onboarding. A little cybersecurity read never hurts.

### Reporting & Escalation

Any doubt about a cyber issue? **Contact your security lead immediately** — don't hesitate.

If you're sure it's a real incident, **escalate to management** as well.

---

## Passwords & Accounts

- Use **a password manager** with unique, strong passwords for anything work-related
- Enable **MFA everywhere**
- Never share passwords or MFA codes in public channels. If you share them in a chat, **delete them immediately after**
- Never paste secrets, access tokens, customer data, or proprietary code into public tools
- Be cautious with browser extensions, especially AI-powered ones

## Device Security - especially for admins

- **Optional: encrypt your disk** (BitLocker on Windows, FileVault on Mac) — store the recovery key in your password manager
- Enable fast **screen lock**
- Keep your OS, browser, password manager, and dev tools **updated**
- Avoid using AI tools in the browser, or use a separate browser with almost no accounts under close watch. Overall AI tools are making us win so much time already. Let's not be careless.
- Reset your browser sessions every so often don't just keep it with all the accounts permanently logged in.

## Key & Credential Hygiene

- **Rotate keys** and remove unused credentials regularly (aim for every 90 days)
- Credentials must be stored in **environment variables**, never in source code, Dockerfiles, or CI/CD pipeline definitions
- Use **pre-commit hooks** to detect and block accidental credential commits, to do this:
	- `pip install pre-commit`
	- ``pre-commit install``
	- ``pre-commit autoupdate``
	- [gitleaks](https://github.com/gitleaks/gitleaks/releases)

## AI Coding Assistants

> Copilot, Claude Code, Cursor, etc.

![[Gemini_Generated_Image_c1s8b8c1s8b8c1s8 (1).png]]

- **Treat AI output like untrusted code** — quick review before accepting except if it's a prototype
	- Require tests before merge (unit + security-relevant tests)
	- Verify crypto choices and auth flows — AI often suggests weak or legacy patterns
	- Do periodic dependency reviews
	- Recommended: CodeRabbit for automated code review
- **Always** have backups when working with AI. At least git history.
- If you're using `--dangerously-skip-permissions`
	- use a [container](https://code.claude.com/docs/en/devcontainer) or [sandbox](https://code.claude.com/docs/en/sandboxing), or another [code-container](https://github.com/kevinMEH/code-container) - something
	- use auto-mode instead (also make sure it's not just a text guardrail protecting your db)
- Make sure your coding assistant **doesn't train on your data**:
	  - GitHub Copilot: [disable training](https://github.com/settings/copilot/features)
	  - Claude Code: disable training in the settings
- Recommended reading:
	  - [Claude Code Mastery Guide](https://thedecipherist.github.io/claude-code-mastery/)
	  - [Claude Code Hooks](https://karanbansal.in/blog/claude-code-hooks/)

Don't trust AI.
![[1000047877.jpg]]

## MCP Servers & Agent Tools

- **Limit** the number of MCP servers you use, and **document** every one you have configured
	- Verify MCP servers before use with a scanner like [Snyk Agent Scan](https://github.com/snyk/agent-scan)
- MCP servers are inherently risky — they can change at any point and interact directly with your agent
	- Run MCP/tooling with **least privilege** (scoped tokens, read-only where possible) to avoid damaging your accounts
	- Check the **full OAuth URL** before approving access, even if it looks legit — [watch this explainer](https://www.youtube.com/watch?v=AzitcyanQvE)

## Prompt Injection & Data Exfiltration

When building applications that use AI, treat all user content and retrieved content as hostile input:

- **Sanitize inputs** where feasible
- **Rate-limit** prompts and tool calls
- **Enforce allowlists** for tools, domains, and actions
- Don't let the model decide access control — enforce it in code

## Supply Chain Security

- Enable **GitHub Dependabot** (or equivalent) on all repositories - it's free and easy
- Watch for random or hallucinated packages in AI-generated code
	- use [context7 MCP](https://github.com/context7/context7) for verified docs
	- Install [Aikido malware scanning](https://help.aikido.dev/code-scanning/aikido-malware-scanning) globally for packages protection
- Prefer signed/verified artifacts when available, avoid untrusted third-party APIs and code
- Consider generating [SBOMs (CycloneDX)](https://cyclonedx.org/tool-center/) for each app to track dependencies
- Avoid using new shiny tools, they'll be full of unknown vulnerabilities upon release

## Application Security Basics

![[Gemini_Generated_Image_c1s8b8c1s8b8c1s8.png]]

- Enable security headers, CSRF protection, and secure cookie settings
- Always review an app's security posture before production deployment
- At minimum, run AI-assisted **security prompts** against the codebase
- Use **Snyk Code** (or equivalent) to scan for common issues like leaked keys
- Perform **pen-testing** before shipping anything to production

## Logging, Monitoring & Response

- Log auth events, tool invocations, and model/API calls with enough context to investigate
- Alert on unusual access patterns and unusual model usage (spikes, new regions, atypical params)
- Have a clear **escalation path** for suspected prompt injection or leaked secrets

---

## Further Reading

- [Cybersecurity Coalition e-learning](https://cybersecuritycoalition.be/resource/cybersecurity-elearning/) — Security awareness training
- [Secure Behaviour Framework](https://cybersecuritycoalition.be/resource/secure-behavior-framework/) — Recommended security behaviors
- [NCSC Top Tips for Staff](https://www.ncsc.gov.uk/training/top-tips-for-staff-scorm-v2/scormcontent/index.html#/) — Quick awareness course
- [SafeOnWeb](https://safeonweb.be/en) — Belgian cybersecurity resources
- [Spear Fishing AI](https://www.youtube.com/watch?v=vX1b_X2rfak&pp=ygULQUkgcGhpc2hpbmc%3D) - Informative video
