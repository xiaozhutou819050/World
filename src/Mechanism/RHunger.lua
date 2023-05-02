--- lua_plus ---
--- lua_plus ---
--- lua_plus ---
--- skip_undefined ---
RMana:trigger = base.trigger_new(coroutine.will_async(function(当前触发器:trigger, e:trigger_args)
    local All:单位组 = base.get_all_units()
    if  then
        for unit:unit, _:integer in pairs(base.unit_group_get_items_map(All)) do
            local u = UnitTable[base.unit_get_id(unit)]--从库中获取改单位的单位表
            Change_SI(u,"digestion", u.RSI)--调用单位饱食度消耗函数
            --base.unit_set_ex(unit, "饱食", H, 1)
        end
    end
end), {
    base.trigger_event_wrapper_timer_periodic(5)--每5秒判断
}, false, nil)