#!/usr/bin/env bash
# sync-obsidian.sh — Bootstrap or sync .obsidian from .obsidian_template
#
# Usage: ./sync-obsidian.sh
#
# First run (no .obsidian/): copies the full template directory.
# Subsequent runs (sync mode): adds new plugins from the template without
# removing anything or overwriting user plugin settings (data.json).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE="$SCRIPT_DIR/.obsidian_template"
TARGET="$SCRIPT_DIR/.obsidian"

if [ ! -d "$TEMPLATE" ]; then
  echo "Error: .obsidian_template not found at $TEMPLATE" >&2
  exit 1
fi

# ── Initial setup ────────────────────────────────────────────────────────────

if [ ! -d "$TARGET" ]; then
  echo "No .obsidian found — creating from template..."
  cp -r "$TEMPLATE" "$TARGET"
  echo "Done. Open the vault in Obsidian."
  exit 0
fi

# ── Sync mode ────────────────────────────────────────────────────────────────

echo "Syncing plugins from template..."

TMPL_PLUGINS_JSON="$TEMPLATE/community-plugins.json"
TARGET_PLUGINS_JSON="$TARGET/community-plugins.json"
TMPL_PLUGINS_DIR="$TEMPLATE/plugins"
TARGET_PLUGINS_DIR="$TARGET/plugins"

# Merge community-plugins.json: add template entries not already in user list
if [ -f "$TMPL_PLUGINS_JSON" ] && [ -f "$TARGET_PLUGINS_JSON" ]; then
  python3 - "$TMPL_PLUGINS_JSON" "$TARGET_PLUGINS_JSON" <<'EOF'
import json, sys

tmpl_file, target_file = sys.argv[1], sys.argv[2]

with open(tmpl_file) as f:
    tmpl = json.load(f)
with open(target_file) as f:
    target = json.load(f)

added = []
for plugin_id in tmpl:
    if plugin_id not in target:
        target.append(plugin_id)
        added.append(plugin_id)

with open(target_file, "w") as f:
    json.dump(target, f, indent=2)
    f.write("\n")

if added:
    print(f"  Added to community-plugins.json: {', '.join(added)}")
else:
    print("  community-plugins.json already up to date")
EOF
elif [ -f "$TMPL_PLUGINS_JSON" ] && [ ! -f "$TARGET_PLUGINS_JSON" ]; then
  cp "$TMPL_PLUGINS_JSON" "$TARGET_PLUGINS_JSON"
  echo "  Copied community-plugins.json from template"
fi

# Sync each plugin folder from template
if [ -d "$TMPL_PLUGINS_DIR" ]; then
  mkdir -p "$TARGET_PLUGINS_DIR"
  for plugin_dir in "$TMPL_PLUGINS_DIR"/*/; do
    plugin_id="$(basename "$plugin_dir")"
    target_plugin="$TARGET_PLUGINS_DIR/$plugin_id"
    mkdir -p "$target_plugin"

    # Always update plugin code files (template is authoritative)
    for code_file in manifest.json main.js styles.css; do
      if [ -f "$plugin_dir$code_file" ]; then
        cp "$plugin_dir$code_file" "$target_plugin/$code_file"
      fi
    done

    # Copy data.json only as a first-time default — never overwrite user settings
    if [ -f "$plugin_dir/data.json" ] && [ ! -f "$target_plugin/data.json" ]; then
      cp "$plugin_dir/data.json" "$target_plugin/data.json"
      echo "  $plugin_id: copied default data.json"
    fi

    echo "  $plugin_id: synced"
  done
fi

echo "Done."

# ── Claude Code plugin check ──────────────────────────────────────────────────

SETTINGS="$SCRIPT_DIR/.claude/settings.json"
INSTALLED="$HOME/.claude/plugins/installed_plugins.json"

if [ -f "$SETTINGS" ] && [ -f "$INSTALLED" ]; then
  echo ""
  echo "Checking Claude Code plugins..."
  python3 - "$SETTINGS" "$INSTALLED" <<'EOF'
import json, sys

with open(sys.argv[1]) as f:
    settings = json.load(f)
with open(sys.argv[2]) as f:
    installed = json.load(f).get("plugins", {})

required = list(settings.get("enabledPlugins", {}).keys())
missing = [p for p in required if p not in installed]

for p in required:
    status = "✗ missing" if p in missing else "✓ installed"
    print(f"  {status}  {p}")

if missing:
    print("")
    print("Install missing plugins in Claude Code:")
    for p in missing:
        print(f"  /plugin install {p}")
    print("(Marketplaces are pre-configured via extraKnownMarketplaces in .claude/settings.json)")
EOF
fi
