MTA Weather System API
===========

API do MTA umożliwające pobierać realną pogodę

Autorzy
========================================================================

- Rick <Main Developer>

Licencja
========================================================================

Kod dystrybuowany jest licencji: GPLv3.

Polskie tłumaczenie licencji GPLv3: http://gnu.org.pl/text/licencja-gnu.html

Zawartość repozytorium
========================================================================

W repozytorium znajduje się:
* Kod LUA serwera
* Struktura bazy danych
* Dodatkowe wymagane moduły

INSTALACJA
========================================================================

1. Umieszczenie wszystkich folderów i plików za wyjątkiem "php/weather" w folderze docelowym serwera MTASA
2. Umieszczenie folderu i plików "php/weather" na hostingu internetowym lub programie typu XAMPP (httpDocs)
3. Skofigurowanie shared/config/API.lua (Settings_API.path = "Twoja ścieżka do strony z plikami PHP weather";)

Dodawanie nowych lokacji
=========================================================================

1. Edycja pliku "client/classes/weather.lua" lini 6

self.zone = {["Los Santos"]	= 1, ["San Fierro"] = 2, ["Las Venturas"] = 3, ["Twoja nowa strefa"] = 4}

2. Dodanie nowej strefy do klienta PHP

2.1. Pobieramy realną pogodę z serwera pogodowego danej strefy po przez stronę https://openweathermap.org/api

$zoneArray[0] = generateXMLWeather("http://api.openweathermap.org/data/2.5/weather?q=Los+Angeles&mode=xml&units=metric&APPID=e648971715d8148ded25c9f7fedb884b"); //Los Santos
    $zoneArray[1] = generateXMLWeather("http://api.openweathermap.org/data/2.5/weather?q=San+Francisco&mode=xml&units=metric&APPID=e648971715d8148ded25c9f7fedb884b"); //San Fierro
    $zoneArray[2] = generateXMLWeather("http://api.openweathermap.org/data/2.5/weather?q=Las+Vegas&mode=xml&units=metric&APPID=e648971715d8148ded25c9f7fedb884b"); //Las Venturas
$zoneArray[4] = generateXMLWeather("link wygenerowany z strony openweathermap");

DOKUMENTACJA
========================================================================


