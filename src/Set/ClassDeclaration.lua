ClassDeclaration = {}

--#region———:机制————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

	--[[资质分别影响一个隐藏属性
		体质：
		爆发
		灵敏：影响生物属性中的反应react
		精神：
		技巧：影响体力的百分比降低
	]]--

--#endregion:机制————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————




--————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
--#region———:Unit类声明————————————————————

Unit = Class(function(self)
--#region———:数值相关————————————————————
	--最大四维值和当前四维值默认为100
	self.MaxHP = 100
	self.MaxSP = 100
	self.MaxPP = 100
	self.HP = 100
	self.SP = 100
	self.PP = 100
	--暴击格挡连击反击机制属性暴击伤害，格挡减伤，连击程度，反击程度
	self.CrtP = 1.5
	self.BlkP = 0.67
	self.DhD = 30
	self.ChD = 30
	--默认资质相关
	self.IGStr = 1--资质成长.种族指数——1周围波动
	self.IGPow = 1
	self.IGDex = 1
	self.IGInt = 1
	self.IGSki = 1
	self.GR = 0--资质波动指数——代表x成上下波动，4代表60%~140%
	self.Lv = 1
	self.id = 0
	--默认原始属性（若有属性上的增减，即为对原始属性的增减）
	self.IRHP = 0
	self.IRSP = 0
	self.IRPP = 0
	self.IAtk = 0
	self.IDef = 0
	self.IPer = 0
	self.IRes = 0
	self.IAsp = 0
	self.IMsp = 0
	self.IHit = 0
	self.IMis = 0
	self.ICrt = 0
	self.IBlk = 0
	self.IDh = 0
	self.ICh = 0
--#endregion:数值相关————————————————————
	
--#region———:生物相关————————————————————带	tab缩进的表示非默认下可变动（其他种族）
	--*饱食相关
	self.MaxSI = 100
	self.SI = 100
	self.Nutrient = 0--营养值
		self.RSI = -5
		self.Nutrient_conver = {0.1,0.1,0.1}--三个阶段饱食度转化营养值比率，正常为10:1

	--*成长相关
	self.Period = 1--生长周期：Child、Adult、Old....
	self.Growth = 0--成长值
	self.Growth_conver = {}
		self.Growth_conver[1] = {1,2}--三种周期下，每60s会消耗Growth_conver[1]点营养值，增加Growth_conver[2]点成长值
		self.Growth_conver[2] = {1,2}
		self.Growth_conver[3] = {1,2}

	--*生物状态：状态值*状态权重 +-（正向P为+，负向N为-） 记忆参数*记忆中该状态的次数*单位反应值 
		self.react = 1--单位反应力默认为1
	for i=1,#State do--遍历全局变量 状态表的数量，表示为字符串连接的12345...
		self["StateN" .. i] = 0--每个对应的状态的初始数值为0
			self["StateW" .. i] = 1--每个对应的状态的权重  初始为1，后续根据不同种族变动
	end
	self.Pmemory_HP = {}--各项数值的正面/负面记忆库；P为正：Positive，N为负面：Negative 
	self.Pmemory_SP = {}
	self.Pmemory_PP = {}
	self.Pmemory_SI = {}
	self.Nmemory_HP = {}
	self.Nmemory_SP = {}
	self.Nmemory_PP = {}
	self.Nmemory_SI = {}
--#endregion———:生物相关————————————————————
end)

--——————————————————————————————————————————————————————————————————————————————————————————————————
--#region———:类方法————————————————————

function Unit:QuaF()--资质算法公式
	self.GStr = Rrandom(self.IGStr,self.GR)--实际资质成长——资质成长.种族指数*波动范围得到一个值
	self.GPow = Rrandom(self.IGPow,self.GR)
	self.GDex = Rrandom(self.IGDex,self.GR)
	self.GInt = Rrandom(self.IGInt,self.GR)
	self.GSki = Rrandom(self.IGSki,self.GR)
	self.QuaStr1,self.QuaStr2,self.QuaStr3 = QuaRandom()--每项资质所影响对应三个属性的百分比率，每项在16.6%~50%之间，三项和为100%
	self.QuaPow1,self.QuaPow2,self.QuaPow3 = QuaRandom()
	self.QuaDex1,self.QuaDex2,self.QuaDex3 = QuaRandom()
	self.QuaInt1,self.QuaInt2,self.QuaInt3 = QuaRandom()
	self.QuaSki1,self.QuaSki2,self.QuaSki3 = QuaRandom()
end

function Unit:AttribF()--资质&属性更新（生成&升级）
	--实际资质--初始值+Lv*成长(下面为合并同类项的简化)
	--体质、爆发、灵敏、智慧、技巧
	self.Str = self.GStr*(QuaData.QuaInit + self.Lv)
	self.Pow = self.GPow*(QuaData.QuaInit + self.Lv)
	self.Dex = self.GDex*(QuaData.QuaInit + self.Lv)
	self.Int = self.GInt*(QuaData.QuaInit + self.Lv)
	self.Ski = self.GSki*(QuaData.QuaInit + self.Lv)

	--实际属性--健康值、理智值、体力值；攻击、防御、感知、意志、攻速、移速；命中、闪避、暴击、格挡、连击、反击
	--健康值、理智值、体力值
	self.RHP = self.IRHP + QuaData.Str3 * self.QuaStr3 * self.Str
	self.RSP = 10 + self.IRSP + QuaData.Int3 * self.QuaInt3 * self.Int
	self.RPP = 15 + self.IRPP + QuaData.Str2 * self.QuaStr2 * self.Str
	--攻击、防御、感知、意志、攻速、移速
	self.Atk = self.IAtk + QuaData.Pow1 * self.QuaPow1 * self.Pow
	self.Def = self.IDef + QuaData.Str1 * self.QuaStr1 * self.Str
	self.Per = self.IPer + QuaData.Int1 * self.QuaInt1 * self.Int
	self.Res = self.IRes + QuaData.Int2 * self.QuaInt2 * self.Int
	self.Asp = 1 + self.IAsp + QuaData.Dex1 * self.QuaDex1 * self.Dex--攻速初始值为100%，可能要改
	self.Msp = 200 + self.IMsp + QuaData.Pow3 * self.QuaPow3 * self.Pow
	--命中、闪避、暴击、格挡、连击、反击
	self.Hit = 0.9 + self.IHit + QuaData.Pow2 * self.QuaPow2 * self.Pow--命中基础值为90%
	self.Mis = self.IMis + QuaData.Dex2 * self.QuaDex2 * self.Dex
	self.Crt = self.ICrt + QuaData.Ski1 * self.QuaSki1 * self.Ski
	self.Blk = self.IBlk + QuaData.Ski2 * self.QuaSki2 * self.Ski
	self.Dh = self.IDh + QuaData.Dex3 * self.QuaDex3 * self.Dex
	self.Ch = self.ICh + QuaData.Ski3 * self.QuaSki3 * self.Ski
end

function Unit:StateParameter()--资质算法公式
	for i = 1,#State,1 do
		self["StateW"..i] = self["StateW"..i] * Rrandom(1,5)
	end
end

function Unit:eat(FoodId)--Creature进食方法声明
	if FoodId == nil then
	print(self.Name.."准备进食")
	--判断物品栏内是否有可供进食的食物
	if UnitHaveFood(self ,label ) == true then
		print(self.Name.."开始进食")
		UnitEat(self ,label )--执行单位吃的动作
		print(self.Name.."结束进食")
	else
		print(self.Name.."身上无可食用食物")
	end
	else
	
	end
end

function Unit:drink()--Creature饮水方法声明
	print(self.Name.."准备饮水")
	--判断物品栏内是否有可供饮用的水
	if UnitHaveFood(self ,label ) == true then
		print(self.Name.."开始饮水")
		UnitEat(self ,label )--执行单位饮水的动作
		print(self.Name.."结束饮水")
	else
		print(self.Name.."背包里无可饮用饮水")
	end
end
--#endregion:类方法————————————————————
--——————————————————————————————————————————————————————————————————————————————————————————————————

--#endregion:Unit类声明————————————————————
--————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————




--————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
--#region———:Race类声明————————————————————

Human = Class(Unit,function(self,Lv) --继承Unit父类，id为单位id
  Unit._ctor(self) --调用父类的_ctor给obj表初始化，相当于继承了父类的元素，十分重要的一行

	self.Lv = Lv

    self.Diet = {"Meat","Vegan"}
	self.MaxAge = 100
	
	--资质相关
	self.IGStr = 1--资质成长.种族指数——1周围波动
	self.IGPow = 1
	self.IGDex = 1
	self.IGInt = 1
	self.IGSki = 1
	self.GR = 1--资质波动指数——代表x成上下波动，4代表60%~140%
	
	self:QuaF()--资质算法公式
	self:AttribF()--生成资质&属性
	self:StateParameter()--状态因子生成
end)

--#region———:类方法————————————————————



--#endregion:类方法————————————————————

--#endregion:Race类声明————————————————————
--————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————


return ClassDeclaration