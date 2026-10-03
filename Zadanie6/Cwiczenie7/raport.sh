#!/usr/bin/env bash
set -euo pipefail
 
METODA="bash"
PLIK="sprzedaz.csv"
 
usage() {
  printf 'Użycie: %s [-m bash|awk] [-f PLIK]\n' "${0##*/}" >&2
  exit 2
}
 
while getopts ":m:f:h" opcja; do
  case "${opcja}" in
    m) METODA="${OPTARG}" ;;
    f) PLIK="${OPTARG}" ;;
    h) usage ;;
    *) usage ;;
  esac
done
 
if [[ ! -f "${PLIK}" ]]; then
  echo "Błąd: Plik ${PLIK} nie istnieje!" >&2
  exit 1
fi
 
raport_bash() {
  declare -A sumy
  declare -A liczniki
 
  while IFS=',' read -r data region kwota || [[ -n "${data}" ]]; do
    [[ -z "${region}" ]] && continue
    sumy["${region}"]=$(( ${sumy["${region}"]:-0} + kwota ))
    liczniki["${region}"]=$(( ${liczniki["${region}"]:-0} + 1 ))
  done < "${PLIK}"
 
  printf '%-12s %-15s %-15s\n' "Region" "Suma" "Średnia"
  for reg in "${!sumy[@]}"; do
    local s=${sumy["${reg}"]}
    local l=${liczniki["${reg}"]}
    local sr=$(( l > 0 ? s / l : 0 ))
    printf '%-12s %-15d %-15d\n' "${reg}" "${s}" "${sr}"
  done
}
 
raport_awk() {
  awk -F',' '
  {
    region=$2; kwota=$3;
    sumy[region] += kwota;
    liczniki[region] += 1;
  }
  END {
    printf "%-12s %-15s %-15s\n", "Region", "Suma", "Średnia";
    for (r in sumy) {
      sr = (liczniki[r] > 0) ? int(sumy[r] / liczniki[r]) : 0;
      printf "%-12s %-15d %-15d\n", r, sumy[r], sr;
    }
  }' "${PLIK}"
}
 
main() {
  case "${METODA}" in
    bash) raport_bash ;;
    awk)  raport_awk ;;
    *)    usage ;;
  esac
}
 
main "$@"
