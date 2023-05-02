--- lua_plus ---
--- skip_undefined ---
InterfaceF = {}

--#region———:Statement————————————————————
-- weee = base.get_unit_from_id(0)--从编号中获取单位
-- reeee = base.unit_get_id(e.unit)--获取单位编号
--#endregion:Statement————————————————————

--#region———:Data————————————————————
Itest1 = "$$default_units.unit.星火战士.root"
Itest = "$$world_7q4a.unit.羊.root"

--#endregion:Data————————————————————

--#region———:Function————————————————————

--创造单位
function IUnitCreate(x,y,p,num)
        base.player_create_unit_ai(base.player(p), num, base.scene_point(x, y, "default"), 0, false)
        local id = base.unit_get_id(base.get_last_created_unit())--获取最后创建单位的编号
        return id
end

--单位固定数据赋值（四值上限等）
function IUnitDataFix(a)
      	base.unit_set_ex(base.get_unit_from_id(a.id), "生命上限", a.MaxHP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "理智上限", a.MaxSP, 1)
	      base.unit_set_ex(base.get_unit_from_id(a.id), "魔法上限", a.MaxPP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "饱食上限", a.MaxSI, 1)
        
        base.unit_set_ex(base.get_unit_from_id(a.id), "饥饿速度", a.RateHunger, 1)--饥饿速率为5点/分钟
end

--单位属性对接
function InterFaceQuaF(a)
        base.unit_set_ex(base.get_unit_from_id(a.id), "生命", a.HP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "理智", a.SP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "魔法", a.PP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "饱食", a.SI, 1)

        base.unit_set_ex(base.get_unit_from_id(a.id), "体质", a.Str, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "爆发", a.Pow, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "灵敏", a.Dex, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "精神", a.Int, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "技巧", a.Ski, 1)

        base.unit_set_ex(base.get_unit_from_id(a.id), "生命恢复速度", a.RHP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "理智恢复速度", a.RSP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "魔法恢复速度", a.RPP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "饱食度消耗速度", a.RSI, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "攻击", a.Atk, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "护甲", a.Def, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "感知", a.Per, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "意志", a.Res, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "攻击速度", a.Asp, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "移动速度", a.Msp, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "命中", a.Hit, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "闪避", a.Mis, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "暴击", a.Crt, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "格挡", a.Blk, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "连击", a.Dh, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "反击", a.Ch, 1)
        
        base.unit_set_ex(base.get_unit_from_id(a.id), "暴击伤害", a.CrtP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "格挡减伤", a.BlkP, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "连击程度", a.DhD, 1)
        base.unit_set_ex(base.get_unit_from_id(a.id), "反击程度", a.ChD, 1)
end
function IF_HP(a)
        base.unit_set_ex(base.get_unit_from_id(a.id), "生命", a.HP, 1)
end
function IF_SP(a)
        base.unit_set_ex(base.get_unit_from_id(a.id), "理智", a.SP, 1)
end
function IF_PP(a)
        base.unit_set_ex(base.get_unit_from_id(a.id), "魔法", a.PP, 1)
end
function IF_SI(a)
        base.unit_set_ex(base.get_unit_from_id(a.id), "饱食", a.SI, 1)
end

--#endregion:Function————————————————————

return InterfaceF