#!/usr/bin/env bash
# scripts/push-to-final-site.sh
# ---------------------------------------------------------------
# Re-point this local repo to https://github.com/Aleater3/Final-Site
# and push the `main` branch safely.
#
# Usage:
#   ./scripts/push-to-final-site.sh            # perform the repoint + push
#   ./scripts/push-to-final-site.sh --dry-run  # print commands, don't run them
#   ./scripts/push-to-final-site.sh --verify   # sanity checks only, no changes
#   ./scripts/push-to-final-site.sh --help     # show this header
#
# Environment overrides:
#   NEW_REMOTE_URL  (default: https://github.com/Aleater3/Final-Site.git)
#   REMOTE_NAME     (default: origin)
#   TARGET_BRANCH   (default: main)
# ---------------------------------------------------------------

set -euo pipefail

NEW_REMOTE_URL="${NEW_REMOTE_URL:-https://github.com/Aleater3/Final-Site.git}"
REMOTE_NAME="${REMOTE_NAME:-origin}"
TARGET_BRANCH="${TARGET_BRANCH:-main}"

DRY_RUN=0
VERIFY_ONLY=0

log()  { printf '▶ %s\n' "$*"; }
warn() { printf '⚠️  %s\n' "$*" >&2; }
err()  { printf '❌ %s\n' "$*" >&2; }
ok()   { printf '✅ %s\n' "$*"; }

run() {
  printf '   $ %s\n' "$*"
  if [[ "$DRY_RUN" -eq 0 ]]; then
    eval "$@"
  fi
}

usage() { sed -n '2,16p' "$0"; }

for arg in "$@"; do
  case "$arg" in
    --dry-run|-n) DRY_RUN=1 ;;
    --verify|-v)  VERIFY_ONLY=1 ;;
    --help|-h)    usage; exit 0 ;;
    *) err "Unknown option: $arg"; usage; exit 64 ;;
  esac
done

# ---------- Sanity ----------
command -v git >/dev/null 2>&1 || { err "git not on PATH"; exit 1; }
git rev-parse --is-inside-work-tree >/dev/null 2>&1 \
  || { err "Not inside a git repo"; exit 1; }

# ---------- Detached HEAD guard ----------
# `git symbolic-ref --quiet HEAD` exits non-zero when HEAD is detached.
# This is a cleaner test than `git branch --show-current` (which returns
# an empty string + exit 0 on detached HEAD, causing the rename step to
# blow up with a confusing error).
if ! git symbolic-ref --quiet --short HEAD >/dev/null 2>&1; then
  err "HEAD is detached. Check out a real branch (e.g. 'git checkout main' or 'git switch -c main') and re-run."
  exit 1
fi

log "Pre-flight snapshot"
PRE_HEAD="$(git rev-parse HEAD)"
PRE_REMOTE="$(git remote get-url "$REMOTE_NAME" 2>/dev/null || echo '<none>')"
PRE_BRANCH="$(git branch --show-current)"
log "Current HEAD:    $PRE_HEAD"
log "Current branch:  $PRE_BRANCH"
log "Current remote:  $REMOTE_NAME -> $PRE_REMOTE"

if [[ "$VERIFY_ONLY" -eq 1 ]]; then
  ok "Verify-only mode complete. No changes made."
  exit 0
fi

# ---------- Refuse if working tree is dirty ----------
if [[ -n "$(git status --porcelain)" ]]; then
  warn "Working tree is dirty:"
  git status --short >&2 || true
  if [[ "$DRY_RUN" -eq 0 ]]; then
    err "Aborting. Commit or stash your changes first."
    exit 2
  fi
fi

# ---------- Safety tag (local only) ----------
SAFETY_TAG="pre-finalsite-$(date +%Y%m%d-%H%M%S)"
log "Creating local safety tag: $SAFETY_TAG"
run "git tag -f \"$SAFETY_TAG\" \"$PRE_HEAD\""

# ---------- Repoint remote ----------
log "Repointing '$REMOTE_NAME' -> $NEW_REMOTE_URL"
run "git remote set-url \"$REMOTE_NAME\" \"$NEW_REMOTE_URL\""
run "git remote -v"

# ---------- Reconcile branch ----------
CURRENT_BRANCH="$(git branch --show-current)"
if [[ "$CURRENT_BRANCH" != "$TARGET_BRANCH" ]]; then
  log "Renaming branch: $CURRENT_BRANCH -> $TARGET_BRANCH"
  run "git branch -M \"$TARGET_BRANCH\""
fi
log "Active branch is now: $(git branch --show-current)"

# ---------- Push ----------
log "Pushing $TARGET_BRANCH -> $REMOTE_NAME"
run "git push -u \"$REMOTE_NAME\" \"$TARGET_BRANCH\""

# ---------- Verify ----------
log "Verifying tracking"
run "git branch -vv"
run "git rev-parse --abbrev-ref '@{u}'"

ok "Done."
ok "Verify on GitHub : https://github.com/Aleater3/Final-Site"
ok "Vercel deploy    : Vercel auto-deploys on push to 'main'. Watch the Deployments tab."
ok "Rollback         : git remote set-url $REMOTE_NAME $PRE_REMOTE"
ok "Safety tag       : $SAFETY_TAG (local only)"
