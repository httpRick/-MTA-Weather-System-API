Weather_Manager = inherit(Singleton)

function Weather_Manager:constructor()
	self.instances = false;
	self:initManager();
end

function Weather_Manager:initManager()
	if not self.instances then
		self.instances = Weather:new();
	end
end

function Weather_Manager:destructor()
	self.instances:destrcutor();
	self.instances = nil;
end
