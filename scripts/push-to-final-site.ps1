# scripts/push-to-final-site.ps1
# ---------------------------------------------------------------
# Re-point this local repo to https://github.com/Aleater3/Final-Site
# and push the `main` branch safely. (Native Windows PowerShell)
#
# Usage:
#   .\scripts\push-to-final-site.ps1             # perform repoint + push
#   .\scripts\push-to-final-site.ps1 -DryRun     # print commands, don't run them
#   .\scripts\push-to-final-site.ps1 -VerifyOnly  # sanity checks only, no changes
#   .\scripts\push-to-final-site.ps1 -Help        # show usage
#
# Environment overrides:
#   $env:NEW_REMOTE_URL  (default: https://github.com/Aleater3/Final-Site.git)
#   $env:REMOTE_NAME     (default: origin)
#   $env:TARGET_BRANCH   (default: main)
# ---------------------------------------------------------------

[CmdletBinding()]
param(
  [switch]$DryRun,
  [switch]$VerifyOnly,
  [switch]$Help
)

# Make `throw` actually halt. PowerShell defaults to 'Continue' which
# would let script continue past an explicit `throw`.
$ErrorActionPreference = 'Stop'

$NewRemoteUrl = if ($env:NEW_REMOTE_URL) { $env:NEW_REMOTE_URL } else { "https://github.com/Aleater3/Final-Site.git" }
$RemoteName   = if ($env:REMOTE_NAME)    { $env:REMOTE_NAME }    else { "origin" }
$TargetBranch = if ($env:TARGET_BRANCH)  { $env:TARGET_BRANCH }  else { "main" }

function Log  { param($m) Write-Host "▶ $m" -ForegroundColor Cyan }
function Warn { param($m) Write-Host "⚠️  $m" -ForegroundColor Yellow }
function Err  { param($m) Write-Host "❌ $m" -ForegroundColor Red }
function Ok   { param($m) Write-Host "✅ $m" -ForegroundColor Green }

<#
  Invoke git with an explicit arg array.
  - No Invoke-Expression (avoids string re-parsing).
  - No backtick-quote escaping (avoids hideous `\"...\"` patterns).
  - No '@{u}' interpolation fragility (args passed as discrete values).
  Honors $DryRun by only printing.
  Throws on non-zero exit so $ErrorActionPreference = 'Stop' aborts cleanly.
#>
function Run-Git {
  param([Parameter(Position=0)][string[]]$GitArgs)

  $display = 'git ' + ($GitArgs -join ' ')
  Write-Host "   $ $display" -ForegroundColor DarkGray

  if (-not $DryRun) {
    & git @GitArgs | Out-Null
    if ($LASTEXITCODE -ne 0) {
      throw "git exited $LASTEXITCODE on: $display"
    }
  }
}

if ($Help) {
  Get-Content $MyInvocation.MyCommand.Path -TotalCount 16 | ForEach-Object { Write-Host $_ }
  exit 0
}

# ---------- Sanity ----------
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Err "git not on PATH"; exit 1
}

# Detached HEAD guard: exit code is the cleanest signal (rather than
# parsing the stdout of `git branch --show-current` which is empty + 0).
& git symbolic-ref --quiet HEAD 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
  Err "HEAD is detached. Check out a real branch (e.g. 'git checkout main' or 'git switch -c main') and re-run."
  exit 1
}

Log "Pre-flight snapshot"
$x = & git rev-parse HEAD                       ; if ($LASTEXITCODE -ne 0) { Err "Could not read HEAD"; exit 1 }
$preHead   = $x
$x = & git remote get-url $RemoteName 2>$null   ; if ($LASTEXITCODE -ne 0) { $x = '<none>' }
$preRemote = $x
$x = & git branch --show-current    2>$null      ; if ($LASTEXITCODE -ne 0) { Err "Could not determine current branch"; exit 1 }
$preBranch = $x
Log "Current HEAD:    $preHead"
Log "Current branch:  $preBranch"
Log "Current remote:  $RemoteName -> $preRemote"

if ($VerifyOnly) {
  Ok "Verify-only mode complete. No changes made."
  exit 0
}

# ---------- Refuse if working tree is dirty ----------
# 2>$null suppresses leaking raw `fatal:` error text on the console; the
# explicit exit check prevents silently proceeding with $null = clean when
# git itself errors (corrupt repo, permissions, etc.).
$dirty = & git status --porcelain 2>$null
if ($LASTEXITCODE -ne 0) { Err "Could not read working tree status"; exit 1 }
if ($dirty) {
  Warn "Working tree is dirty:"
  Write-Host $dirty -ForegroundColor Yellow
  if (-not $DryRun) {
    Err "Aborting. Commit or stash your changes first."
    exit 2
  }
}

# ---------- Safety tag (local only) ----------
$tag = "pre-finalsite-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Log "Creating local safety tag: $tag"
Run-Git @('tag','-f',$tag,$preHead)

# ---------- Repoint remote ----------
Log "Repointing $RemoteName -> $NewRemoteUrl"
Run-Git @('remote','set-url',$RemoteName,$NewRemoteUrl)
Run-Git @('remote','-v')

# ---------- Reconcile branch ----------
$current = & git branch --show-current
if ($current -ne $TargetBranch) {
  Log "Renaming branch: $current -> $TargetBranch"
  Run-Git @('branch','-M',$TargetBranch)
}
Log "Active branch is now: $TargetBranch"

# ---------- Push ----------
Log "Pushing $TargetBranch -> $RemoteName"
Run-Git @('push','-u',$RemoteName,$TargetBranch)

# ---------- Verify ----------
Log "Verifying tracking"
Run-Git @('branch','-vv')
Run-Git @('rev-parse','--abbrev-ref','@{u}')

Ok "Done."
Ok "Verify on GitHub : https://github.com/Aleater3/Final-Site"
Ok "Vercel deploy    : Vercel auto-deploys on push to 'main'. Watch the Deployments tab."
Ok "Rollback         : git remote set-url $RemoteName $preRemote"
Ok "Safety tag       : $tag (local only)"
