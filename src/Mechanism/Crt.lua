--- lua_plus ---
--- lua_plus ---
--- skip_undefined ---
Crt:trigger = base.trigger_new(coroutine.will_async(function(当前触发器:trigger, e:trigger_args)
    if  then
        local CrtP:unknown = 100 * base.unit_get_attribute_ex(e.unit, "暴击", 0)
        local m:unknown = math.random(1, 100)
        local old_hurt:unknown = e.amount
        local hurt_power:unknown = base.unit_get_attribute_ex(e.unit, "暴击伤害", 0)
        --log.info(CrtP .. "、" .. m .. "、" .. old_hurt .. "、" .. hurt_power)
        if CrtP > m then
            --log.info("触发暴击！")
            base.damage_set_current_damage(e.damage, (old_hurt * hurt_power))
        end
    end
end), {
    base.trigger_event_wrapper_unit(base.any_unit, "造成伤害")
}, false, nil)