Prototype = {}

function Prototype:new(...)
    if self.mt_Instance then
        return self.mt_Instance
    end
    local inst = new(self, ...)
    self.mt_Instance = inst
    return inst
end

function Prototype:ctor()
    self._objects = {}
end

function Prototype:register_object(name, obj)
    self._objects[name] = obj
end

function Prototype:unregister_object(name)
    self._objects[name] = nil
end

function Prototype:clone(name, params)
    local obj = self._objects[name] or {}
    local new = {}
    local params = params or {}
    for k,v in pairs(obj) do
        new[k] = params[k] or v
    end
    return new
end

Prototype.__call = Prototype.new
setmetatable(Prototype, {__call = Prototype.__call})
