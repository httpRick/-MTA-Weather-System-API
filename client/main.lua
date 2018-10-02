Manager = false

function initWeatherClientSystem()
	Manager = Weather_Manager:new();
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), initWeatherClientSystem)

function respondeDataUpdate(respondeData)
	Manager.instances:update(respondeData);
end
addEvent( "Weather:respondeDataUpdate", true )
addEventHandler( "Weather:respondeDataUpdate", root, respondeDataUpdate)
