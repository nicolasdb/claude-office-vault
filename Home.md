# Claude Office

## Team

```dataview
TABLE WITHOUT ID
  link(file.path, regexreplace(file.folder, "team/", "")) AS "Name",
  Role,
  Joined
FROM "team"
WHERE file.name = "profile" AND Role != null
SORT Joined ASC
```

[[team/roster|Full Roster]]

## Projects

```dataview
TABLE Status, Lead
FROM "projects"
WHERE file.name = "status" AND Status != null
SORT Status ASC
```

## My Tasks

```dataview
TASK FROM "team"
WHERE !completed AND contains(text, "#P0") OR contains(text, "#P1")
SORT priority ASC
LIMIT 15
```

## Blockers

```dataview
TASK FROM "team"
WHERE !completed AND contains(text, "#blocker")
```

## Quick Links

- [[projects/status|All Projects Status]]
- [[team/roster|Team Roster]]
- [[projects/security/guidelines|Security Guidelines]]
- [[projects/security/compliance|Compliance Dashboard]]

---

> *Set this as your Obsidian startup note: Settings > Appearance > Open on startup*
