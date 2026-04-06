# sync-obsidian.ps1 — Bootstrap or sync .obsidian from .obsidian_template
#
# Usage: .\sync-obsidian.ps1
#
# First run (no .obsidian\): copies the full template directory.
# Subsequent runs (sync mode): adds new plugins from the template without
# removing anything or overwriting user plugin settings (data.json).

$ErrorActionPreference = "Stop"

$ScriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$Template    = Join-Path $ScriptDir ".obsidian_template"
$Target      = Join-Path $ScriptDir ".obsidian"

if (-not (Test-Path $Template)) {
    Write-Error "Error: .obsidian_template not found at $Template"
    exit 1
}

# -- Initial setup ---------------------------------------------------------------

if (-not (Test-Path $Target)) {
    Write-Host "No .obsidian found - creating from template..."
    Copy-Item -Recurse -Path $Template -Destination $Target
    Write-Host "Done. Open the vault in Obsidian."
    exit 0
}

# -- Sync mode -------------------------------------------------------------------

Write-Host "Syncing plugins from template..."

$TmplPluginsJson  = Join-Path $Template "community-plugins.json"
$TargetPluginsJson = Join-Path $Target  "community-plugins.json"
$TmplPluginsDir   = Join-Path $Template "plugins"
$TargetPluginsDir = Join-Path $Target   "plugins"

# Merge community-plugins.json: add template entries not already in user list
if ((Test-Path $TmplPluginsJson) -and (Test-Path $TargetPluginsJson)) {
    $tmplList   = Get-Content $TmplPluginsJson  -Raw | ConvertFrom-Json
    $targetList = Get-Content $TargetPluginsJson -Raw | ConvertFrom-Json

    # ConvertFrom-Json returns PSCustomObject for arrays in older PS; ensure list
    $targetArray = [System.Collections.Generic.List[string]]($targetList)
    $added = @()

    foreach ($id in $tmplList) {
        if ($targetArray -notcontains $id) {
            $targetArray.Add($id)
            $added += $id
        }
    }

    $targetArray | ConvertTo-Json | Set-Content $TargetPluginsJson -Encoding UTF8

    if ($added.Count -gt 0) {
        Write-Host "  Added to community-plugins.json: $($added -join ', ')"
    } else {
        Write-Host "  community-plugins.json already up to date"
    }
} elseif ((Test-Path $TmplPluginsJson) -and -not (Test-Path $TargetPluginsJson)) {
    Copy-Item $TmplPluginsJson $TargetPluginsJson
    Write-Host "  Copied community-plugins.json from template"
}

# Sync each plugin folder from template
if (Test-Path $TmplPluginsDir) {
    if (-not (Test-Path $TargetPluginsDir)) {
        New-Item -ItemType Directory -Path $TargetPluginsDir | Out-Null
    }

    foreach ($pluginDir in Get-ChildItem -Path $TmplPluginsDir -Directory) {
        $pluginId     = $pluginDir.Name
        $targetPlugin = Join-Path $TargetPluginsDir $pluginId

        if (-not (Test-Path $targetPlugin)) {
            New-Item -ItemType Directory -Path $targetPlugin | Out-Null
        }

        # Always update plugin code files (template is authoritative)
        foreach ($codeFile in @("manifest.json", "main.js", "styles.css")) {
            $src = Join-Path $pluginDir.FullName $codeFile
            if (Test-Path $src) {
                Copy-Item $src (Join-Path $targetPlugin $codeFile) -Force
            }
        }

        # Copy data.json only as a first-time default — never overwrite user settings
        $tmplData   = Join-Path $pluginDir.FullName "data.json"
        $targetData = Join-Path $targetPlugin "data.json"
        if ((Test-Path $tmplData) -and -not (Test-Path $targetData)) {
            Copy-Item $tmplData $targetData
            Write-Host "  ${pluginId}: copied default data.json"
        }

        Write-Host "  ${pluginId}: synced"
    }
}

Write-Host "Done."

# -- Claude Code plugin check ----------------------------------------------------

$SettingsFile  = Join-Path $ScriptDir ".claude\settings.json"
$InstalledFile = Join-Path $env:USERPROFILE ".claude\plugins\installed_plugins.json"

if ((Test-Path $SettingsFile) -and (Test-Path $InstalledFile)) {
    Write-Host ""
    Write-Host "Checking Claude Code plugins..."

    $settings  = Get-Content $SettingsFile  -Raw | ConvertFrom-Json
    $installed = (Get-Content $InstalledFile -Raw | ConvertFrom-Json).plugins

    $required = $settings.enabledPlugins.PSObject.Properties.Name
    $missing  = @()

    foreach ($plugin in $required) {
        if ($installed.PSObject.Properties.Name -contains $plugin) {
            Write-Host "  [ok] $plugin"
        } else {
            Write-Host "  [!]  $plugin  (not installed)"
            $missing += $plugin
        }
    }

    if ($missing.Count -gt 0) {
        Write-Host ""
        Write-Host "Install missing plugins in Claude Code:"
        foreach ($plugin in $missing) {
            Write-Host "  /plugin install $plugin"
        }
        Write-Host "(Marketplaces are pre-configured via extraKnownMarketplaces in .claude/settings.json)"
    }
}
