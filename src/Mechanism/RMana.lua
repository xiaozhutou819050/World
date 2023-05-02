--- lua_plus ---
--- lua_plus ---
--- lua_plus ---
--- skip_undefined ---
RMana:trigger = base.trigger_new(coroutine.will_async(function(当前触发器:trigger, e:trigger_args)
    local All:单位组 = base.get_all_units()
    if  then
        for unit:unit, _:integer in pairs(base.unit_group_get_items_map(All)) do
            local M:unknown = base.unit_get_attribute_ex(unit, "魔法", 1)
            local M1:unknown = base.unit_get_attribute_ex(unit, "魔法上限", 1)
            local M2:unknown = base.unit_get_attribute_ex(unit, "魔法恢复速度", 1)
            local M3:unknown = base.unit_get_attribute_ex(unit, "魔法", 1) / base.unit_get_attribute_ex(unit, "魔法上限", 1)
            local M4:unknown = M + 0.1 * M2 * M3
            if M4 <= M1 then
                base.unit_set_ex(unit, "魔法", M4, 1)
            end
        end
    end
end), {
    base.trigger_event_wrapper_timer_periodic(0.1)
}, false, nil)