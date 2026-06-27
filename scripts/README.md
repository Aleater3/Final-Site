# Deployment Scripts

These scripts re-point this local repository to the **Final-Site** GitHub repo
(`https://github.com/Aleater3/Final-Site`) and push the `main` branch safely,
without losing code state and with a one-line rollback path.

## Files

| File | Use it on |
|---|---|
| `push-to-final-site.sh`  | Git Bash, Linux, macOS, WSL |
| `push-to-final-site.ps1` | Native Windows PowerShell |

> **Note on line endings:** Git Bash on Windows tolerates CRLF for `.sh` scripts,
> but native Linux/macOS bash may not. If you see
> `bash: ./scripts/push-to-final-site.sh: /bin/bash^M: bad interpreter: No such file or directory`,
> the file has CRLF endings — run `dos2unix scripts/push-to-final-site.sh` to fix.
> After that, `chmod +x scripts/push-to-final-site.sh` to make it executable.

## Usage

### 1. Dry run first (recommended)

```bash
./scripts/push-to-final-site.sh --dry-run
# or
.\scripts\push-to-final-site.ps1 -DryRun
```

This prints every command without executing it. Read every line.

### 2. Verify only

```bash
./scripts/push-to-final-site.sh --verify
# or
.\scripts\push-to-final-site.ps1 -VerifyOnly
```

### 3. Run for real

```bash
./scripts/push-to-final-site.sh
# or
.\scripts\push-to-final-site.ps1
```

## What the script does

1. Confirms `git` is installed and the working directory is inside a git repo.
2. Refuses to run if `HEAD` is detached.
3. Snapshots your current `HEAD`, branch name, and remote URL.
4. **Refuses to run** if the working tree is dirty (unless dry-run).
5. Creates a local safety tag `pre-finalsite-<YYYYMMDD-HHMMSS>` for easy rollback.
6. Repoints `origin` to `https://github.com/Aleater3/Final-Site.git`.
7. Renames the active branch to `main` if needed.
8. Pushes `main` to the new remote and sets upstream tracking.
9. Verifies upstream tracking and prints a final summary.

After the push succeeds, **Vercel picks up the new commit on `main` within ~30
seconds** and triggers a production deployment automatically — no extra steps
required on Vercel's side.

## Rollback

If you need to undo the re-point:

```bash
git remote set-url origin <previous-url>
```

The previous URL is printed in the script output. Your local history,
commits, and tags are untouched by this whole operation.

## Edge case: GitHub auto-created an `Initial commit`

If the new repo on GitHub was created with a default README, GitHub may have
made an `Initial commit` on `main`. Push will fail with
`! [rejected] main -> main (non-fast-forward)`. Fix with the safe variant
of force-push:

```bash
git push --force-with-lease origin main
```

`--force-with-lease` is preferred over `--force` — it refuses to clobber
remote work you haven't seen.

## Environment overrides

| Variable | Default |
|---|---|
| `NEW_REMOTE_URL` | `https://github.com/Aleater3/Final-Site.git` |
| `REMOTE_NAME`    | `origin` |
| `TARGET_BRANCH`  | `main` |

Example:

```bash
NEW_REMOTE_URL=https://github.com/Aleater3/Final-Site.git \
  ./scripts/push-to-final-site.sh --dry-run
```
