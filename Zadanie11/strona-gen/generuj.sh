#!/bin/bash
set -euo pipefail

WEJSCIE="${1:?Podaj plik CSV}"
WYJSCIE="${2:?Podaj katalog wyjściowy}"
mkdir -p "${WYJSCIE}"

LICZBA_PROD=$(grep -c ';produkcja;' "${WEJSCIE}" || true)

{
  echo '<!DOCTYPE html><html lang="pl"><head><meta charset="utf-8">'
  echo '<title>Katalog usług</title></head><body>'
  echo '<h1>Katalog usług zespołu</h1><table border="1"><tr><th>Usługa</th><th>Status</th><th>Właściciel</th></tr>'
  tail -n +2 "${WEJSCIE}" | while IFS=';' read -r nazwa status wlasciciel; do
    printf '<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n' "${nazwa}" "${status}" "${wlasciciel}"
  done
  echo "</table><p>Liczba usług w produkcji: ${LICZBA_PROD}</p>"
  echo '<p>Wygenerowano podczas budowania obrazu.</p></body></html>'
} > "${WYJSCIE}/index.html"

echo "Wygenerowano $(wc -l < "${WYJSCIE}/index.html") linii HTML" >&2
