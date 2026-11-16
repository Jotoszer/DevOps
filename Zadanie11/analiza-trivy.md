# Analiza bezpieczeństwa obrazów (Trivy)

## 1. Tabela porównawcza skanowanych obrazów

| Obraz | Łączna liczba podatności | Liczba HIGH / CRITICAL | Liczba HIGH / CRITICAL z poprawką (`Fixed Version`) |
| :--- | :---: | :---: | :---: |
| `katalog-uslug:1.0.0` (Ćwiczenie 4) | <N> | <N> | 0 |
| `ubuntu:24.04` | <N> | <N> | <N> |
| `nginx:1.20` | <N> | <N> | <N> |

## 2. Decyzje dla wybranych podatności z najstarszego obrazu (`nginx:1.20`)

1. **Naprawiamy (podniesienie obrazu bazowego):** Podatność `HIGH`/`CRITICAL` w pakiecie `openssl` (lub `libssl`) ze statusem `fixed` — ponieważ Nginx obsługuje ruch sieciowy i szyfrowanie, aktualizujemy obraz bazowy do wspieranej wersji (`nginx:1.27-alpine`) i przebudowujemy obraz.
2. **Nie dotyczy nas:** Podatność w narzędziu lub bibliotece systemowej obecnej w warstwie bazowej Debiana (np. `perl` / `dpkg` / `apt`), której nasza statyczna strona WWW w ogóle nie uruchamia ani nie używa w czasie działania kontenera.
3. **Akceptujemy z terminem przeglądu:** Podatność o statusie `will_not_fix` lub `fix_deferred` (pusta kolumna `Fixed Version`), dla której wydawca nie udostępnił jeszcze łatki — dopisujemy identyfikator CVE do pliku `.trivyignore` z komentarzem i datą ponownego przeglądu przy kolejnej aktualizacji bazy.
