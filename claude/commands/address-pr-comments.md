User input: $ARGUMENTS

Take the comments from the user input (it may be blank) and user comments on the corresponding PR to this branch (if it exists). 

The user probably put in two kinds of comments:
1. Questions for discussion or clarification
2. Direct commands to change how code words

For type #1 comments, respond #1 directly on the relevant comment. Prepend [CLAUDE] to make it clear it's coming from you.

For type #2 comments, make new branch called updates/pr-123-202601011345 (updates/pr-[pr number]-[timestamp yyyymmddhhmm]) changes in code then create a new PR wherein the new branch is being merged into the underlying feature branch. On the relevant parts of the PR, put a comment that has the full comment history which drove the change. [Mo Zhu] for my comments [Claude] for your comments.


