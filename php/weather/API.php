<?php
	function generateXMLWeather($url)
    {
    	$xml = simplexml_load_file($url);
    	$tempArray = array();
    	$tempArray[] = strtolower($xml->weather['value']);
		$tempArray[] = number_format((float)$xml->temperature['value'], 2);
		$tempArray[] = number_format((float)$xml->wind->speed['value'], 2);
		$tempArray[] = strtolower($xml->wind->direction['code']);
		$tempArray[] = strtoupper($xml->city['name']);
		return $tempArray;
    }
    $zoneArray = array();
    $zoneArray[0] = generateXMLWeather("http://api.openweathermap.org/data/2.5/weather?q=Los+Angeles&mode=xml&units=metric&APPID=e648971715d8148ded25c9f7fedb884b"); //Los Santos
    $zoneArray[1] = generateXMLWeather("http://api.openweathermap.org/data/2.5/weather?q=San+Francisco&mode=xml&units=metric&APPID=e648971715d8148ded25c9f7fedb884b"); //San Fierro
    $zoneArray[2] = generateXMLWeather("http://api.openweathermap.org/data/2.5/weather?q=Las+Vegas&mode=xml&units=metric&APPID=e648971715d8148ded25c9f7fedb884b"); //Las Venturas
    echo("[ " . json_encode($zoneArray) . " ]");
?>
