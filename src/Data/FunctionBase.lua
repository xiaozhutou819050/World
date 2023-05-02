FunctionBase = {}

--表赋值———t赋给新表tm
function ClassTable_Transfer(t,tm)
	local c = getmetatable(t)
	for k,v in pairs(c) do--找到表内方法，全部复制够来
		if type(c[k]) == "function" then
			tm[k] = c[k]
		end
	end
	for k,v in pairs(t) do--将表t的内容赋给tm新表
		tm[k]=v 
	end
	t = {}--删除被赋值的表，节省空间
end

--范围随机———a：中心数；b：变动范围，单位1/10
function Rrandom(a,b)
	local m = math.random(10-b,10+b)
	return a*m/10
end

--资质指数———每项资质影响的三个属性的比率，最低0.5最高1.5，三项和为3--计算过程：X=1.5  Y<1；0.5<Y<3-(X+Zmin)；X=0.5  Y>1；3-(X+Zmax)<Y<1.5
function QuaRandom()
	local x,y,z
	x = math.random(5,15)
	if x >10 then
		y = math.random(5,25-x)
	else
		y = math.random(15-x,15)
	end
	z = 30 - x - y
	return x/10,y/10,z/10
end

--单位生成———单位( race, lv，坐标x，坐标y，所属player，对应物编单位)
function UnitCreate(race, lv, x, y , p, num)
	local a = race(M,lv)--声明类Race，并生成生物各项属性
	a.id = IUnitCreate(x,y,p,num)--对接游戏单位创造接口，并获取返回的单位id
	UnitTable[id] = a--编辑器内可通过id来获得库内的单位表
	IUnitDataFix(a)--为单位生成固定属性（四值上限均为100）
	InterFaceQuaF(a)--单位数据更新，与单位的类数据匹配
	return a--返回生成的类Race
end

--饱食度变化
function Change_SI(u,cause,value)
	--记录此次数值变化（原因、数值），分别存入正面记忆和负面记忆	
	if value > 0 then
		table.insert(u.Pmemory_SI, { cause, value })
	else
		table.insert(u.Nmemory_SI, { cause, value })
	end
	--判断此次消耗饱食是否会导致扣除健康值
	local H = u.SI + value
	if H >= 0 then
		u.SI = H--执行数值变化
	else
		u.SI = 0--执行数值变化
		Change_HP(u,"hunger", -0.1 * u.MaxHP)--扣除健康值执行
	end
end

--健康值变化
function Change_HP(u,cause,value)
	--记录此次数值变化（原因、数值），分别存入正面记忆和负面记忆	
	if value > 0 then
		table.insert(u.Pmemory_HP, { cause, value })
	else
		table.insert(u.Nmemory_HP, { cause, value })
	end
	--执行数值变化
	u.HP = u.HP + value
end




























return FunctionBase