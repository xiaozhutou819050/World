ClassMonitor = {}
--————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
--region———:Monitor函数声明——————————————————————

--健康值相关
function M_HP(self, HP, old_HP)
	--老数值为表（第一次创建该值）或单位id为空时，直接结束整个函数	
	if type(old_HP) == "table" or self.id == nil then
		return
	end
	--四维数值为负数时的判定，直接变为0
	if HP < 0 then 
		self.HP = 0
	end
	if HP < 10 then
		print("!!!")
	end
	--异常抛出
	pcall(function()
		IF_HP(self)
	end)
end

--理智值相关
function M_SP(self, SP, old_SP)
	--老数值为表（第一次创建该值）或单位id为空时，直接结束整个函数	
	if type(old_SP) == "table" or self.id == nil then
		return
	end
	--四维数值为负数时的判定，直接变为0
	if SP < 0 then 
		self.SP = 0
	end
	--异常抛出
	pcall(function()
		IF_SP(self)
	end)
end

--体力值相关
function M_PP(self, PP, old_PP)
	--老数值为表（第一次创建该值）或单位id为空时，直接结束整个函数	
	if type(old_PP) == "table" or self.id == nil then
		return
	end
	--四维数值为负数时的判定，直接变为0
	if PP < 0 then 
		self.PP = 0
	end
	--异常抛出
	pcall(function()
		IF_PP(self)
	end)
end

--饱食度相关：消化系统
function M_SI(self, SI, old_SI)
	--老数值为表（第一次创建该值）或单位id为空时，直接结束整个函数	
	if type(old_SI) == "table" or self.id == nil then
		return
	end
	local d = SI - old_SI--变化值
	--四维数值为负数时的判定，直接变为0，然后赋值饱食度
	if SI < 0 then 
		self.SI = 0
	end
	--异常抛出
	pcall(function()
		IF_SI(self)
	end)
	

	if d<0 then--此次变化值为负&正
		--判断此次（即记录中最后一次添加的饱食度变化记录中）饱食度变化原因是否为“消化”，是则增加对应营养值
		if self.Nmemory_SI[#self.Nmemory_SI][1] == "digestion" then
			self.Nutrient = self.Nutrient + (-1)*d*self.Nutrient_conver[self.Period]
			print("消耗饱食度:"..(-1)*d.."，增加营养值："..(-1)*d*self.Nutrient_conver[self.Period])
		end
	else

	end
end

--升级相关
function M_Lv(self, Lv, old_Lv)
	--老数值为表（第一次创建该值）或单位id为空时，直接结束整个函数	
	if type(old_Lv) == "table" or self.id == nil then
		return
	end
	--触发升级时，对应属性变化
	local l = Lv - old_Lv
	if l > 0 then
		--log.info("id为："..self.id.."的单位触发升级".."，从"..old_Lv.."升到"..Lv.."，当前等级为："..self.lv)
		self:AttribF()--资质&属性更新
		InterFaceQuaF(self)--接口属性对接
	end
end

--生命活动相关
function M_VitalActivity(self,Nutrient,old_Nutrient)
	--老数值为表（第一次创建该值）或单位id为空时，直接结束整个函数	
	if type(old_Nutrient) == "table" or self.id == nil then
		return
	end
end

--成长相关
function M_Growth(self,Growth,old_Growth)
	--老数值为表（第一次创建该值）或单位id为空时，直接结束整个函数	
	if type(old_Growth) == "table" or self.id == nil then
		return
	end
	if self.Growth >= 100 then
		self.Period = self.Period + 1
		self.Growth = 0
		print("单位"..self.id.."触发周期迭代，目前周期为："..Period[self.Period]..self.Period)
	end
end

function M_Period(self,Period,old_Period)
	if type(old_Period) == "table" or self.id == nil then
		return
	end
	if self.Period > 3 then--营养值满了，触发周期迭代
		print("id为"..self.id.."的单位老死了，目前周期为："..self.Period)
	end
end

function M_Digest_Forage(self,n,old_n)
	if type(old_n) == "table" or self.id == nil then
		return
	end
	
end


--endregion:Monitor函数声明——————————————————————
--————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————



--————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
--region———:Monitor类声明——————————————————————
Monitor = Class(function(self)--Health类声明--
	self.HP = {}
	self.SP = {}
	self.PP = {}
	self.SI = {}
	self.Lv = {}
	self.Nutrient = {}
	self.Growth = {}
	self.Period = {}
	for i = 1,#State,1 do
		self["StateN"..tostring(i)] = {}
	end
	
end,
nil,
{
	HP =  M_HP, --健康值相关
	SP =  M_SP, --健康值相关
	PP =  M_PP, --健康值相关
	SI =  M_SI, --健康值相关
	Lv =  M_Lv, --升级相关
	Nutrient = M_VitalActivity,--生命相关，包括生长等等
	Growth = M_Growth,--记录百分比年纪
	Period = M_Period,--记录周期
	StateN1 = M_Digest_Forage--记录进食度

})
--endregion:Monitor类声明——————————————————————
--————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————



return ClassMonitor