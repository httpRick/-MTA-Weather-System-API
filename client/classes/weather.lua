Weather = inherit(Class)

function Weather:constructor()
	self.binds = {event = {}, func = {} }
	self.temperature = 0
	self.type = { sunny = {0, 1, 10, 11, 17, 18}, clouds = {2, 3, 4, 5, 6, 7}, fog = {9}, stormy = {8}, rainy = {16}, dull = {12, 13, 14, 15} }
	self.zone = {["Los Santos"]	= 1, ["San Fierro"] = 2, ["Las Venturas"] = 3}
	self.now = {}
	self.weather = {}
	self.wind = {}
	self.updateData = {}
	self.current = nil
	self.binds.event.onClientRender = bind(self.onClientRender, self);
	self:init();
end

function Weather:update(respondeData)
	self.now = respondeData
end

function Weather:init()
	addEventHandler("onClientRender", getRootElement(), self.binds.event.onClientRender)
end

function Weather:set(type, rain, level, wave)
	local data = self.type[type][1]
	local name = false
	self.weather.type = data
	self.weather.name = type
	if (data == 8) or (data == 16) then
		local month = getRealTime().month
		if (month == 10) or (month == 11) or (month == 0) then
			data = math.random(12,15)
			setWeatherBlended(data)
		else
			setWeatherBlended(data)
		end
	else
		setWeatherBlended (data)
	end
	setRainLevel((rain and rain or 0))
	setWaterLevel((level and level or 0))
	setWaveHeight((wave and wave or 0.5))

	local celsius = tonumber(math.ceil(self.celsius))
	self.temperature = celsius

	if (type == "clouds") then 
		self.weather.name = "cloudy"
	elseif (type == "fog") then
		self.weather.name = "foggy"
	end
	if (celsius >= -30) and (celsius <= -21) then
		self.weather.name = "very freezing"
	elseif (celsius >= -20) and (celsius <= -11) then
		self.weather.name = "freezing"
	elseif (celsius >= -10) and (celsius <= 0) then
		self.weather.name = "cold"
	elseif (celsius >= 1) and (celsius <= 15) then
		self.weather.name = "chilly"
	elseif (celsius >= 16) and (celsius <= 20) then
		self.weather.name = "somewhat balanced"
	elseif (celsius >= 21) and (celsius <= 24) then
		self.weather.name = "warm"
	elseif (celsius >= 25) and (celsius <= 30) then
		self.weather.name = "hot"
	elseif (celsius >= 31) and (celsius <= 36) then
		self.weather.name = "very hot"
	elseif (celsius >= 37) and (celsius <= 45) then
		self.weather.name = "dangerously hot"
	end
	outputDebugString("[API Weather] Set weather "..self.current[5]..", type: "..self.weather.type.." ( "..self.weather.name.." ), temperature: "..self.temperature.."° wind speed "..self.wind.level.." ("..string.upper(self.wind.dir)..")" )
end

function Weather:FromRemote(data)
	local weather, celsius, wind_level, wind_dir, name = data[1], data[2], data[3], data[4], data[5]
	if (weather == nil) or (celsius == nil) then
		outputDebugString("[API Weather] An error occurred while downloading!", 2)
		return
	else
		self.wind.level = wind_level
		self.wind.dir = wind_dir
		self.celsius = celsius
		outputDebugString("[API Weather] Download settings "..name, 3)
		if (weather == "sky is clear") or (weather == "few clouds") or (weather == "scattered clouds") or (weather == "broken clouds") or (weather == "cold") or (weather == "hot") then
			self:set("sunny")
		elseif (weather == "overcast clouds") then
			self:set("clouds")
		elseif (weather == "light rain") then
			self:set("rainy", 0.8, 0.07)
		elseif (weather == "moderate rain") or (weather == "hail") then
			self:set("rainy", 1.0, 0.1, 0.8)
		elseif (weather == "heavy intensity rain") then
			self:set("rainy", 1.2, 0.35, 1.0)
		elseif (weather == "very heavy rain") then
			self:set("rainy", 1.4, 1.0, 1.6)
		elseif (weather == "extreme rain") or (weather == "tropical storm") then
			self:set("rainy", 1.6, 2.5, 2.0)
		elseif (weather == "freezing rain") or (weather == "hurricane") then
			self:set("rainy", 1.8, 4.0, 2.3)
		elseif (weather == "light intensity shower rain") then
			self:set("rainy", 0.75)
		elseif (weather == "shower rain") then
			self:set("rainy", 0.9)
		elseif (weather == "heavy intensity shower rain") then
			self:set("rainy", 0.8)
		elseif (weather == "light intensity drizzle") then
			self:set("rainy", 0.1)
		elseif (weather == "drizzle") then
			self:set("rainy", 0.2)
		elseif (weather == "heavy intensity drizzle") then
			self:set("rainy", 0.35)
		elseif (weather == "drizzle rain") then
			self:set("rainy", 0.4)
		elseif (weather == "heavy intensity drizzle rain") then
			self:set("rainy", 0.55)
		elseif (weather == "shower drizzle") then
			self:set("rainy", 0.62)
		elseif (weather == "thunderstorm with light rain") then
			self:set("stormy", 0.66, 0.2, 0.8)
		elseif (weather == "thunderstorm with rain") then
			self:set("stormy", 1.0, 0.4, 1.2)
		elseif (weather == "thunderstorm with heavy rain") then
			self:set("stormy", 1.2, 0.75, 1.4)
		elseif (weather == "light thunderstorm") or (weather == "thunderstorm") or (weather == "heavy thunderstorm") or (weather == "ragged thunderstorm") then
			self:set("stormy", 0)
		elseif (weather == "thunderstorm with light drizzle") then
			self:set("stormy", 0.1)
		elseif (weather == "thunderstorm with drizzle") then
			self:set("stormy", 0.2)
		elseif (weather == "thunderstorm with heavy drizzle") then
			self:set("stormy", 0.35)
		elseif (weather == "mist") or (weather == "smoke") or (weather == "fog") then
			self:set("fog")
		elseif (weather == "Sand/Dust Whirls") or (weather == "haze") or (weather == "tornado") or (weather == "windy") then
			self:set("dull", 0.2, 2.1)
		else
			self:set("sunny")
		end
		if (self.wind.dir == "SSE") or (self.wind.dir == "SE") then
			setWindVelocity(self.wind.level, -self.wind.level, self.wind.level)
		elseif (self.wind.dir == "NNE") or (self.wind.dir == "NE") then
			setWindVelocity(self.wind.level, self.wind.level, self.wind.level)
		elseif (self.wind.dir == "NNW") or (self.wind.dir == "NW") then
			setWindVelocity(-self.wind.level, self.wind.level, self.wind.level)
		elseif (self.wind.dir == "SSW") or (self.wind.dir == "SW") then
			setWindVelocity(-self.wind.level, -self.wind.level, self.wind.level)
		elseif (self.wind.dir == "S") then
			setWindVelocity(0.1, -self.wind.level, self.wind.level)
		elseif (self.wind.dir == "N") then
			setWindVelocity(0.1, self.wind.level, self.wind.level)
		elseif (self.wind.dir == "E") then
			setWindVelocity(self.wind.level, 0.1, self.wind.level)
		elseif (self.wind.dir == "W") then
			setWindVelocity(0.1, self.wind.level, self.wind.level)
		else
			setWindVelocity(0.3, 0.3, 0.3)
		end
	end
end

function Weather:onClientRender()
	if getElementInterior( localPlayer ) == 0 then
		if type(self.now) == "table" then
			local position = localPlayer:getPosition()
			local zoneID = self.zone[getZoneName(position, true )]
			local respondeData = self.now[tonumber(zoneID)]
			if respondeData and not(name == "unkown") and not(self.current)  then
				self.current = respondeData
				self:FromRemote(respondeData)
			elseif respondeData and ( self.current and not(self.current[1] == respondeData[1]) or not(self.current[2] == respondeData[2]) or not(self.current[3] == respondeData[3]) or not(self.current[4] == respondeData[4]) ) then
				self.current = respondeData
				self:FromRemote(respondeData)			
			end
		end
	end
end
