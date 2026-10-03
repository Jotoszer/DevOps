#!/usr/bin/env bash
set -euo pipefile

pidy=()
for i in {1..5}; do
./wolny.sh &
pidy+=("$!")
done

bledy_zajete=0
sukcesy=0

for pid in "${pidy[@]}"; do
set +e
wait "${pid}"
kod=$?
set -e
if (( kod ==4 )); then
bledy_zajete=$((bledy_zajete +1))
elif (( kod == 0)); then
sukcesy=$((sukcesy + 1))
fi
done

echo "Zakończono sukcesem (kod 0): ${sukcesy}"
echo "Zablokowano (kod 4): ${bledy_zajete}"
