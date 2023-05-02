require("Data.ComponentLoad")


local a = UnitCreate( Human, 1 ,300,300,1, Itest)
local au = base.get_last_created_unit()
base.player_set_hero(base.player(1), base.get_last_created_unit())--设置主控角色
































--smallcard_unit_attr_panel.绑定玩家全部单位属性面板为单位(base.player(0), au)
--smallcard_unit_attr_panel.绑定玩家全部单位属性面板为单位(base.player(1), au)
--base.unit_set_ex(au, "生命恢复速度", 50, 1)
--base.unit_set_ex(au, "魔法恢复速度", 0, 1)

--a.lv = a.lv + 1




-- for i=1,15 do--显示游戏内单位各项属性
--     log.info(UnitAttribute[i]..base.unit_get_attribute_ex(base.get_unit_from_id(a.id), UnitAttribute[i], 0))
-- end

-- base.player_set_hero(base.player(1), base.get_last_created_unit())--设置主控角色


-- log.info("——————————————————————————")
-- log.info(a.lv)
-- log.info(a.id)
-- 
-- a.HP = a.HP - 80
-- log.info(a.lv)
-- log.info("——————————————————————————")

-- for i=1,15 do--显示单位各项属性
--     log.info(UnitAttribute[i]..base.unit_get_attribute_ex(base.get_unit_from_id(a.id), UnitAttribute[i], 0))
-- end







--log.info(a.Str)