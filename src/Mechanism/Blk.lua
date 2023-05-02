--- lua_plus ---
--- lua_plus ---
--- skip_undefined ---
Blk:trigger = base.trigger_new(coroutine.will_async(function(当前触发器:trigger, e:trigger_args)
    if  then
        local BlkP:unknown = 100 * base.unit_get_attribute_ex(e.unit, "格挡", 0)
        local m:unknown = math.random(1, 100)
        local old_hurt:unknown = e.amount
        local hurt_power:unknown = base.unit_get_attribute_ex(e.unit, "格挡减伤", 0)
        --log.info(BlkP .. "、" .. m .. "、" .. old_hurt .. "、" .. hurt_power)
        if BlkP > 0 then
            log.info"触发格挡！"
            base.damage_set_current_damage(e.damage, (old_hurt * hurt_power))
        end
    end
end), {
    base.trigger_event_wrapper_unit(base.any_unit, "受到伤害")
}, false, nil)