Review my local branch changes before creating a PR. Do not use `gh` commands.

1. Get ALL changes compared to master:
   - `git diff master` for all tracked file changes (committed + uncommitted)
   - `git ls-files --others --exclude-standard` to list untracked files, then read their contents
2. Launch an agent using the Task tool with subagent_type="general-purpose" to review the changes
3. The agent should return two sections:

   **Section 1: Change Summary**
   What do these changes do? What is the underlying intent? Describe the changes and their purpose so I can verify you understood correctly.

   **Section 2: Review Comments**
   - Code quality (readability, maintainability, potential bugs)
   - Test coverage (missing tests, edge cases)
   - Security concerns

Focus on actionable feedback, not nitpicks.
