# Security Compliance Dashboard

> Tags:: #project/security
> Last Updated:: 2026-03-31

This dashboard pulls security fields from each team member's `profile.md`. If a field shows "TBD" or is empty, that person hasn't completed that step yet.

**How to become compliant:** Read the [[guidelines]] and fill in the security section of your `team/<your_name>/profile.md`.

---

## Team Compliance

```dataviewjs
const teamFiles = dv.pages('"team"')
  .where(p => p.file.name === "profile" && !p.file.path.includes("_new_user"))
  .sort(p => p.file.folder);

const metaFields = [
  { key: "Disk Encryption", label: "Disk Enc." },
  { key: "Password Manager", label: "Password Mgr" },
  { key: "MFA Enabled", label: "MFA" },
  { key: "VPN", label: "VPN" }
];

const taskChecks = [
  { label: "Copilot Training", match: "Copilot training data" },
  { label: "MCP Scan", match: "Scanned MCP servers" },
  { label: "Aikido", match: "Aikido malware" },
  { label: "CC Mastery", match: "Claude Code Mastery" }
];

const rows = [];

for (const page of teamFiles) {
  const name = page.file.folder.split("/").pop();

  const metaVals = metaFields.map(f => {
    const val = page[f.key];
    if (!val || val.toString().includes("TBD") || val.toString().trim() === "") return "❌";
    return "✅";
  });

  const taskVals = taskChecks.map(({ match }) => {
    const task = page.file.tasks.find(t => t.text.includes(match));
    return task && task.completed ? "✅" : "❌";
  });

  const allVals = [...metaVals, ...taskVals];
  const done = allVals.filter(v => v === "✅").length;
  const score = `${done}/${allVals.length}`;
  rows.push([name, ...allVals, score]);
}

dv.table(
  ["Name", ...metaFields.map(f => f.label), ...taskChecks.map(t => t.label), "Score"],
  rows
);
```

## Summary

```dataviewjs
const teamFiles = dv.pages('"team"')
  .where(p => p.file.name === "profile" && !p.file.path.includes("_new_user"));

const metaFields = ["Disk Encryption", "Password Manager", "MFA Enabled", "VPN"];
const taskMatches = ["Copilot training data", "Scanned MCP servers", "Aikido malware", "Claude Code Mastery"];

let totalDone = 0;
let totalFields = 0;

for (const page of teamFiles) {
  for (const f of metaFields) {
    totalFields++;
    const val = page[f];
    if (val && !val.toString().includes("TBD") && val.toString().trim() !== "") totalDone++;
  }
  for (const match of taskMatches) {
    totalFields++;
    const task = page.file.tasks.find(t => t.text.includes(match));
    if (task && task.completed) totalDone++;
  }
}

const pct = totalFields > 0 ? Math.round((totalDone / totalFields) * 100) : 0;
dv.paragraph(`**Overall team compliance: ${totalDone}/${totalFields} fields completed (${pct}%)**`);
```
