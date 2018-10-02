Manager = false

function initWeatherServerSystem()
	setTimer(function()
		Manager = Weather_Manager:new();
	end, 1000, 1)
end
addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()), initWeatherServerSystem)
