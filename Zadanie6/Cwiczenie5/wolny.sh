#!/usr/bin/env bash
set -euo pipefail
readonly SKRYPT="${0##*/}"
readonly BLOKADA="${XDG_RUNTIME_DIR:-/tmp}/${SKRYPT}.lock"
readonly KOD_ZAJETE=4

log() {
printf '%s [%s] [%d]: %s\n' \
"$(date -u --iso-8601=seconds)" "${SKRYPT}" "$$" "$*" >&2
}

zaloz_blokade() {
exec 200>"${BLOKADA}"
if ! flock -n 200; then
log "Inny egzemplarz już działa (blokada zajęta) Kończę proces."
exit "${KOD_ZAJETE}
fi
}

main () {
zaloz_blokade
log "START - rozpoczęto pracę"
sleep 15
log "KONIEC - zakończono pracę"
}

main "$@"
