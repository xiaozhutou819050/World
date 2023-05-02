--- lua_plus ---
--- lua_plus ---
--- lua_plus ---
--- skip_undefined ---
RMana:trigger = base.trigger_new(coroutine.will_async(function(当前触发器:trigger, e:trigger_args)
    local All:单位组 = base.get_all_units()
    if  then
        for unit:unit, _:integer in pairs(base.unit_group_get_items_map(All)) do
            local u = UnitTable[base.unit_get_id(unit)]--从库中获取改单位的单位表
            local p = u.Period
            local H = u.Nutrient - u.Growth_conver[p][1]
            if H > 0 then 
                u.Nutrient = H
                u.Growth = u.Growth + u.Growth_conver[p][2]
            else
                --输出营养不足的信号
            end
        end
    end
end), {
    base.trigger_event_wrapper_timer_periodic(60)--每60秒判断
}, false, nil)