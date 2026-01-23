$ARGUMENTS

Create a new worktree for this feature. Worktree name should be {repo-name}--{worktree-name}. Put the worktree in a folder that is a sibling of the current repo.

Be sure to specify in the git command to create a worktree off of master or main branch, not the current branch.

After creating the worktree, output:

```
Worktree created. Open a new terminal tab and run:
cd {worktree-path} && claude
```

Where {worktree-path} is the relative path to the worktree (e.g., `../myrepo--feature-branch`).
