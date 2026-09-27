#!/usr/bin/bash
set -euo pipefail
pokaz_dysk() {
echo "ZAJĘTOŚĆ DYSKU"
df -h
}
pokaz_pamiec() {
echo "PAMIĘĆ RAM"
free -h
}
pokaz_uptime() {
uptime
}
pokaz_siec() {
ip -brief address show || hostname -I
}
use() {
echo "Uzycie: ${0##+/} <polecenie>" >&2
echo "Dostępne polecenia: dysk, pamięć, uptime, sieć, wszystko" >&2
}
main() {
local polecenie="${1:-}"
case "$polecenie" in
dysk)
pokaz_dysk
;;
pamiec)
pokaz_pamiec
;;
siec)
pokaz_siec
;;
wszystko)
pokaz_dysk
pokaz_pamiec
pokaz_uptime
pokaz_siec
;;
-h|--help)
use
return 0
;;
"")
echo "Błąd: brak polecenia" >&2
use
return 2
;;
*)
echo "Błąd: polecenie '$polecenie' nieznane" >&2
use
return 2
;;
esac
}

main "$@"

