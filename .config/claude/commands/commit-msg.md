---
description: "Automatically create SRP-compliant commits for uncommitted changes"
argument-hint: "optional: --dry-run to preview, --push to push after commits"
allowed-tools: ["*"]
---

# Auto Commit with SRP

Automatically analyze and commit all uncommitted changes following Single Responsibility Principle.

## Instructions:

1. First, check git status and analyze all changes
2. Group changes by their logical purpose (feat, fix, refactor, chore, etc.)
3. For each group of related changes:
   - Stage the relevant files
   - Create a commit with proper conventional commit message
   - Show what was committed
4. If --dry-run is specified, only show what would be done without executing
5. If --push is specified, push to remote after all commits
6. Check if any files should be added to .gitignore

## Process:

Parse arguments: $ARGUMENTS

1. Run `git status` to see all changes
2. Run `git diff` for each file to understand what changed
3. Group files by their change purpose
4. Execute commits automatically:
   - Use `git add` for relevant files
   - Use `git commit -m` with proper message
   - Continue with next group
5. Summary of all commits created
6. Suggest .gitignore additions if needed

IMPORTANT: Actually execute the git commands, don't just show them. Make real commits unless --dry-run is specified.