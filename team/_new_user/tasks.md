# Tasks — <PUT YOUR NAME HERE>

## Active

- [ ] Read the [[projects/security/guidelines|security guidelines]] and fill in security fields in profile.md (priority:: P1) (project:: Security) (assigned:: @<PUT YOUR NAME HERE>) #project/Security #P1 #onboarding
  - Set up 1Password, enable MFA everywhere
  - Understand our AI coding security practices
- [ ] Complete vault onboarding (priority:: P1) (project:: ingram-office) (assigned:: @<PUT YOUR NAME HERE>) #project/ingram-office #P1 #onboarding
  - Set up your profile in `profile.md` (picture + fun fact)
  - Replace all `<PUT YOUR NAME HERE>` placeholders
  - Make your first commit and push

## Completed

<!--
Move completed tasks here:
- [x] Task description (completed:: YYYY-MM-DD) (project:: ProjectName) #project/ProjectName
-->

## Backlog

<!--
Lower priority items and future work:
- [ ] Task description (priority:: P3) (project:: ProjectName) #project/ProjectName #P3
-->

---

### Dataview Queries

#### My Active Tasks (sorted by priority)
```dataview
TASK FROM "team/<PUT YOUR NAME HERE>"
WHERE !completed
SORT priority ASC
```

#### My Overdue Tasks
```dataview
TASK FROM "team/<PUT YOUR NAME HERE>"
WHERE !completed AND due < date(today)
SORT due ASC
``` [/] Example item in progress
-->
