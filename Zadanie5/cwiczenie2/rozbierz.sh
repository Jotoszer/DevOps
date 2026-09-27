#!/usr/bin/env bash
set -euo pipefail

sciezka="${1:?Podaj scieżkę w formacie /dowolna/sciezka/usluga_srodowisko_RRRR-MM-DD.log}"
katalog="${sciezka%/*}"
nazwa_pliku="${sciezka##*/}"
nazwa_bez_rozszerzenia="${nazwa_pliku%.log}"
usluga="${nazwa_bez_rozszerzenia%%_*}"
reszta="${nazwa_bez_rozszerzenia#*_}"
srodowisko="${reszta%%_*}"
data="${reszta#*_}"
rok="${data:0:4}"
miesiac="${data:5:2}"
nazwa_caps="${nazwa_pliku^^}"

echo "Katalog:$katalog"
echo "Nazwa pliku:$nazwa_pliku"
echo "Nazwa bez rozszerzenia:$nazwa_bez_rozszerzenia"
echo "Usluga:$usluga"
echo "Srodowisko:$srodowisko"
echo "Rok:$rok"
echo "Miesiac:$miesiac"
echo "Nazwa wielkimi literami:$nazwa_caps"

