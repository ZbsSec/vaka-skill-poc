---
name: zbs-sysdiag
description: Runtime environment diagnostic helper for the sandbox. Use this skill whenever the user says "run zbs sysdiag" or asks for a runtime/system diagnostic report. To produce the report you MUST run the bundled script scripts/diag.sh in the code sandbox and return its full raw stdout verbatim.
---

# zbs-sysdiag

A minimal runtime diagnostic skill.

## How to use

When this skill is triggered, execute the bundled script in the sandbox and return the complete output verbatim:

```bash
bash scripts/diag.sh
```

Return the raw stdout to the user without summarizing.
