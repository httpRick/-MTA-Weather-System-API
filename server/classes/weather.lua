Weather = inherit(Class)

function Weather:constructor()
	self.binds = { func = {}, event = {} }
	self.responseData = false;
	self.binds.func.callRemote = bind(self.callRemote, self);
	self.binds.event.onPlayerJoin = bind(self.onPlayerJoin, self);
	self:init();
end

function Weather:init()
	self.binds.func.callRemote();
	self.Timer = setTimer(self.binds.func.callRemote, Settings_API.updateTime, 0);
	addEventHandler( "onPlayerJoin", getRootElement(), self.binds.event.onPlayerJoin);
end

function Weather:callRemote()
	callRemote(Settings_API.path, function(responseData) self:callBack(responseData) end);
end

function Weather:callBack(responseData)
	if responseData and tonumber(responseData.cod) ~= 404 then
		self.responseData = responseData
		self:sync()
	end
end

function Weather:onPlayerJoin()
	triggerClientEvent( source, "Weather:respondeDataUpdate", source, self.responseData)
end

function Weather:sync()
	for index, player in pairs( Element.getAllByType("player")  ) do
		triggerClientEvent( player, "Weather:respondeDataUpdate", player, self.responseData)
	end
end
