---
description: Update spec.txt
---

## Task Description
You goal is to update the spec.txt file with the latest that have occured on this branch.
The spec.txt file should be considered the technical manual for the project. It does not need to specify how to do certain things but should include all technical details of the project. It is very important this document is up-to-date and accurate.

1. Review @spec.txt in its entirety.
2. Run the following command to get the list of files that have been modified on this branch:
   - `git diff main --name-only`
3. Review the changes in each of the modified files with `git diff <filename>`
4. Review .sessions directory for any recent changes. Be sure to only review sessions related to this branch.
    - Run: `git rev-parse --show-toplevel` to get the repository root path
    - Review session files at `<git-root>/.sessions/`
    - Read `<git-root>/.sessions/index.md`
5. Think very hard about what you should update/include then modify spec.txt with the latest changes. Maintaining the same format as the original spec.txt. 
6. (Optional) Update README.md as needed. 

