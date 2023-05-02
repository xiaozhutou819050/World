Class = {}

--#region———:辅助块——————————————————————

--#region———:监控——————————————————————
EntityId = 1
M = {}
setmetatable(M, {
    _newindex = function(t,k,v)
end
})

function M(obj)--转换obj实例为监控函数
    local obj1 = {}
    obj1 = Monitor(self)
    ClassTable_Transfer(obj,obj1)
    return obj1
end
--endregion:监控——————————————————————

--#region———:Class实现——————————————————————

    local function __index(t, k)
        local p = rawget(t, "_")[k]--先从obj表下的_表读取对应的键
        if p ~= nil then --如果有直接返回
            return p[1]  
        end
        return getmetatable(t)[k]  --没有则去元表，即c中查找
    end

    local function __newindex(t, k, v)
        local p = rawget(t, "_")[k]
        if p == nil then  --如果不是被代理则直接在实例表中修改
            rawset(t, k, v)
        else --如果是被代理的，取出对应的值修改，并触发一个预设的函数
            local old = p[1]
            p[1] = v  --修改
            p[2](t, v, old)  --这里是一个函数调用
        end
    end

    local function __dummy()
    end

--endregion:Class实现——————————————————————

--#endregion:辅助块——————————————————————

function Class(base,_ctor,props)--Class函数声明
    local c={}
    --部分1
    if not _ctor and type(base)=="function" then
        _ctor=base
        base=nil
    elseif type(base) == 'table' then
        for k,v in pairs(base) do
            c[k]=v 
        end
        c.base = base
    end
    --部分2
    if props ~= nil then --如果props表存在，即有需要代理的键，则替换元函数
        c.__index = __index
        c.__newindex = __newindex
    else
        c.__index = c
    end
    --部分3
    local mt={}
    mt.__call=function(class_tbl,Monitor,...)
        local obj={}
        if props ~= nil then --如果需要代理，则遍历，在_表中生成对应的结构
            obj._ = { _ = { nil, __dummy } } --对_做代理，禁止外部通过键访问到真正的_表，__dummy是一个空函数,不过通过rawget rawset还是能拿到
            for k, v in pairs(props) do
                obj._[k] = { nil, v }
            end
        end
        setmetatable(obj,c)

        if Monitor == M then
            if c._ctor then
                c._ctor(obj,...)
            end
            obj = M(obj)
        else
            if c._ctor then
                c._ctor(obj,Monitor,...)
            end
        end
        obj.uid = EntityId--定义实例的uid
        EntityId = EntityId + 1
        return obj
    end

    c._ctor=_ctor 
    --[[
    c.is_a = function(self,klass)
        local m = getmetatable(self)
        while m do
            if m == klass then return true end
            m = m._base 
        end
        return false
    end
    ]]--
    setmetatable(c,mt)
    return c
end

return Class