DataBase = {}

--游戏平衡常数
Time = 0
--RateHunger = 5

--存储单位的表，key为编辑器内单位id
UnitTable = {}

--资质影响的属性值———体质：防御,体力恢复,健康恢复；爆发：攻击,命中,移速；灵敏：攻速,连击,闪避；精神：感知,抗性,理智恢复；技巧：暴击,格挡,反击；
QuaData = {
    --QuaData["Str1"] = 2;QuaData.Str1 = 2;与下面等价
    Str1 = 2;--防御,体力恢复,健康恢复
    Str2 = 0.1;
    Str3 = 0.1;
    Pow1 = 2;--攻击,命中,移速
    Pow2 = 0.01;
    Pow3 = 2;
    Dex1 = 0.01;--攻速,连击,闪避
    Dex2 = 0.01;
    Dex3 = 0.01;
    Int1 = 2;--感知,抗性,理智恢复
    Int2 = 2;
    Int3 = 0.1;
    Ski1 = 0.01;--暴击,格挡,反击
    Ski2 = 0.01;
    Ski3 = 0.01;

    --单位1级各项资质初始值指数--指数*实际资质成长=初始资质值
    QuaInit = 3
}

UnitAttribute = {"魔法上限","生命","理智","魔法","生命恢复速度","理智恢复速度","魔法恢复速度","攻击","护甲","感知","意志","攻击速度","移动速度","命中","闪避","暴击","格挡","连击","反击"}

--周期--Period[1] = "child"
Period = {"child","adult","old"}

--状态--Period[1] = "digest-forage"
State = {
    "digest-forage",--消化-觅食
    "tension-relax",--紧张-放松
    "entertain-work",--娱乐-工作
    "estrus"--发情
}

--Buff
Buff = {}











PackageToUnit = {}
PackageToUnit["1227894868"] = 3
PackageToUnit["1227894834"] = 4
PackageToUnit["1227894871"] = 5
PackageToUnit["1227894872"] = 6

FeedType = {}
FeedType["1227894870"] = "Vegan"--小麦
FeedType["1227894849"] = "Vegan"--干草

FeedingHabits = {}
FeedingHabits["Omnivore"] = {"Meat","Vegan"}
FeedingHabits["carnivore"] = {"Meat"}
























return DataBase