require("Tools")
require("test")
require("invoking")
require("lowfunction")
require("socket")
require("UiData")

--=================================基本功能测试区域=====================
-- defubes a factirual function

-- tools.GetDeviceInfo()
-- tools.StartGame()


-- test.func()

--===================================END==============================

init("0", 1);
--setScreenScale(1280,720) --这里必须是 竖向放置分辨率

-- 模拟器分辨率1280x720
-- 真机分辨率1080X1920
-- 绘图接口 opengl
--=========================全分辨率框架 需要的参数=======================
Dev_Env = {  --开发机环境
Top = 0,Sub = 0,Left = 0,Right = 0,
Width = 1280,
Height = 720
}



local profile_flag = 0
local temp_pix = 0
--获取当前分辨率 如果 height > width 那么就调换这两个参数
local true_height,true_width = getScreenSize()--获取屏幕分辨率
if true_height > true_width then
	--调换参数数据
	temp_pix = true_width
	true_width = true_height
	true_height = temp_pix
end
sysLog("当前得分辨率是"..true_width.."x"..true_height)


--根据实际情况得分辨率来划分不同得初始化函数

--16：9得情况 那肯定是全屏 1.7777777777778
sysLog(true_width/true_height) --将这两个参数带入到一个函数内处理

--============================获取UI层参数===============================
while true do
	--uiret = ui.UI_design()
	uiret = UiData.GetUIData()
	--uiret = ui.NewUIDesign()
	if uiret == true then
		
	else
	
	 break
	end

end
--=====================================================================

--计算分辨率
lowfunction.Resolution_profile(true_width,true_height)








--在这里检查编辑框格式是否有误
check_ret1 = lowfunction.check_edit(Custom1_Skill_edit_glo) --校验编辑框的数据有效性，有效则返回数据列表，无效则返回空数据列表
check_ret2 = lowfunction.check_edit(Custom2_Skill_edit_glo)
check_ret3 = lowfunction.check_edit(Custom3_Skill_edit_glo)
--加载ruler
ruler_table = invoking.ruler_manager()

--显示一条看



if type(edit1_glo) ~= "number" then
	edit1_glo = 1
end


--当前启用
--dialog("当前区服："..tostring(ServerTypeGlo))
sysLog("当前区服："..tostring(ServerTypeGlo))

--这里区分日服国服的一些具体参数  ServerTypeGlo 0 国服 1 日服  2台服
if ServerTypeGlo == 0 then
	
	--AP补充检测点
	APRechargePoint = {69,44}
	--AP补充特征表
	APRechargeTable = {

		Anchor="Middle",MainPoint={x=37,y=45},
		Area={131,21,1153,676},
		{x=209,y=207,color=0x3870a1,offset=0x404040},
		{x=275,y=229,color=0x23435f,offset=0x404040},
		{x=589,y=612,color=0xdcdcdc,offset=0x101010},
		{x=1015,y=162,color=0xf2f2f7,offset=0x101010}

	}
	--助战界面标识
	Helper_flag_table =  
	{
		Anchor="Middle",MainPoint={x=781,y=81},
		Area={2,164,607,637},
		{x=32,y=289,color=0x316173,offset=0x101010},
		{x=68,y=179,color=0x29596b,offset=0x101010},
		{x=500,y=231,color=0xe7eff7,offset=0x101010}
		
	} 
	Destruction_point = {845,587}
	Close_point = {639,585}	


	--全部取消
	All_Cancel_point = {830,547}
	--礼装激活标记  分别对应 5 4 3 2 1 标记外
	Active_Gift_point = {{319,222},{539,225},{745,220},{959,223},{314,302},{536,305},{842,642}}
elseif ServerTypeGlo == 1  then --日服
	--AP补充检测点
	APRechargePoint = {74,44}
	--AP补充特征表
	APRechargeTable = {

		Anchor="Middle",MainPoint={x=37,y=45},
		Area={242,86,1044,656},
		{x=589,y=612,color=0xdeddde,offset=0x151515},
		{x=1015,y=162,color=0xf5f2f9,offset=0x151515},
		{x=710,y=609,color=0xe3e2e3,offset=0x151515},
		{x=725,y=639,color=0xe9eaea,offset=0x151515},
		{x=605,y=625,color=0x070b0f,offset=0x202020},
		{x=1017,y=186,color=0xf2f0f4,offset=0x151515}

	}
	
	Helper_flag_table =  
	 
	 
	{
		Anchor="Middle",MainPoint={x=781,y=81},
		Area={2,164,607,637},
		{x=32,y=289,color=0x316173,offset=0x101010},
		{x=68,y=179,color=0x29596b,offset=0x101010},
		{x=500,y=231,color=0xe7eff7,offset=0x101010}
		
	} 
	
	Destruction_point = {844,624} --844,624
	Close_point = {645,631}	 --645,631

	--全部取消832,442
	All_Cancel_point = {832,442}
	--礼装激活标记  分别对应 5 4 3 2 1 标记外
	Active_Gift_point = {{318,273},{542,279},{755,274},{951,276},{314,354},{523,356},{849,635}}

elseif ServerTypeGlo == 2 then  --台服
	--AP补充检测点
	APRechargePoint = {69,44}
	--AP补充特征表
	APRechargeTable = {

		Anchor="Middle",MainPoint={x=37,y=45},
		Area={131,21,1153,676},
		{x=209,y=207,color=0x3870a1,offset=0x404040},
		{x=275,y=229,color=0x23435f,offset=0x404040},
		{x=589,y=612,color=0xdcdcdc,offset=0x101010},
		{x=1015,y=162,color=0xf2f2f7,offset=0x101010}

	}
	Helper_flag_table =  
	{
		Anchor="Middle",MainPoint={x=781,y=81},
		Area={0,0,1280,177},
		{x=218,y=46,color=0x3b608d,offset=0x101010},
		{x=155,y=41,color=0xd6d7d8,offset=0x101010},
		{x=498,y=128,color=0xfcfcfc,offset=0x101010}
		
	} 
	Destruction_point = {845,587}
	Close_point = {639,585}	


	--全部取消
	All_Cancel_point = {830,547}
	--礼装激活标记  分别对应 5 4 3 2 1 标记外
	Active_Gift_point = {{319,222},{539,225},{745,220},{959,223},{314,302},{536,305},{842,642}}


end


--大功能选择
if main_func_glo == 0 then   --自动故事模式
	Tools.GetSingleHud("刷剧情模式开启")
	local Helper_os = true
	local Room_os = true
	FreeTypeFuncGlo = 2 --切换为故事模式开头
	for i=1,edit1_glo,1 do
		mSleep(math.random(1000,3000))
		do_ret = invoking.Game_Start(Room_os,Helper_os,false,true)
		ProgramSum = ProgramSum + 1 --在这里对脚本运行次数自增
		if do_ret == 1 then 
			edit1_glo = edit1_glo + 1
		end
	end
	
	
end


if main_func_glo == 1 then  --刷剧情
		--这里插入动画
	Tools.GetSingleHud("刷剧情free开启")
	local Helper_os = true
	local Room_os = true
	for i=1,edit1_glo,1 do
		mSleep(math.random(1000,3000))
		do_ret = invoking.Game_Start(Room_os,Helper_os,false,true)
		ProgramSum = ProgramSum + 1 --在这里对脚本运行次数自增
		if do_ret == 1 then --自然回体返回
			edit1_glo = edit1_glo + 1
		end
	end

end

if main_func_glo == 2 then  --刷free
		--这里插入动画
	Tools.GetSingleHud("Free开启")
	
	local Helper_os = true
	local Room_os = true
	for i=1,edit1_glo,1 do
		mSleep(math.random(1000,3000))
		do_ret = invoking.Game_Start(Room_os,Helper_os,true,false)
		ProgramSum = ProgramSum + 1 --在这里对脚本运行次数自增
		if do_ret == 1 then --自然回体返回
			edit1_glo = edit1_glo + 1
		end
	end

end


if main_func_glo == 3 then
	--这里插入动画
	Tools.GetSingleHud("狗粮1开启")
	invoking.Get_Exp(edit1_glo)
end

if main_func_glo == 4 then
	--这里插入动画
	Tools.GetSingleHud("狗粮2开启")
	invoking.Get_Gift_Exp(edit1_glo)
end

if main_func_glo == 5 then
		--这里插入动画
	Tools.GetSingleHud("贩卖开启")
	lowfunction.Sale(edit1_glo,true)
end

--一键智能模式（小白模式）
if main_func_glo == 6 then
	--这里初始化所有ui设置参数
	--=============================UI参数定义==============================
	-- config_func_glo = tonumber(results.radiogroup0)
	-- main_func_glo = tonumber(results.radiogroup1) --0 刷free 1 喂狗粮 2 喂礼装
	-- edit1_glo = tonumber(results.edit1)--刷取次数edit1
	AP_recharge_func_glo = 1  --0 圣晶石 1黄金苹果 2白银 3青铜
	Helper_func_glo = 1 --0 --呆毛王 小莫 大王 闪闪 水呆毛  孔明 梅林 艳后 杰克 白枪呆 纳尔逊 拉二 船长 奶光 黑狗 黑贞
	Helper_gift_func_glo = 1 --迦勒底午餐时光 圣夜晚餐
	Helper_mode_func_glo = 0  --助战方式 随便选一个 只选英灵 只选礼装 两者都要

	Master_switch_func_glo = 1 --换人开关 是 否
	Stella_switch_func_glo = 1 --关闭大英雄
	

	Baoju_do_func_glo = 0 --0 - 小于1个 1-小于2个
	Card_color_func_glo = 0 --红卡 蓝卡 绿卡偏重
	Card_type_func_glo = 0 -- '首卡染色', '三色卡','克制出卡','助战出卡','一人出一卡'
	level = 0
	-- preGroup_func_glo = results.preGroup --预警参数获取
	--第一面
	fire_in_func_1_glo = 2 --集火左 中 右
	buff_func_1_glo = 2 --buff左 中 右
	Skill_req1_glo = 0  --技能释放要求
	Skill_op1_func_glo = '0@3@6@12@13@14' --'左1', '左2', '左3', '中1','中2','中3','右1','右2','右3','宝具左','宝具中','宝具右','御主1','御主2','御主3'
	-- Custom1_Skill_edit_glo = results.edit51

	--第二面
	fire_in_func_2_glo = 2 --左 中 右
	buff_func_2_glo = 2  --左 中 右
	Skill_req2_glo = 0
	Skill_op2_func_glo =  '0@3@6@12@13@14'
	-- Custom2_Skill_edit_glo = results.edit52
	--第三面
	fire_in_func_3_glo = 2 --左 中 右
	buff_func_3_glo = 2 --左 中 右
	Skill_req3_glo = 0
	Skill_op3_func_glo =  '0@3@6@12@13@14'
	--Custom3_Skill_edit_glo = results.edit53
	--重载ruler
	check_ret1 = '' --校验编辑框的数据有效性，有效则返回数据列表，无效则返回空数据列表
	check_ret2 = ''
	check_ret3 = ''
	ruler_table = invoking.ruler_manager()
	--这里插入动画
	Tools.GetSingleHud("小白Free开启")
	local Helper_os = true
	local Room_os = true
	for i=1,edit1_glo,1 do
		mSleep(math.random(1000,3000))
		do_ret = invoking.Game_Start(Room_os,Helper_os,false,false)
		if do_ret == 1 then --自然回体返回
			edit1_glo = edit1_glo + 1
		end
	end
end



if main_func_glo == 7 then
	--这里插入动画
	Tools.GetSingleHud("无限池开启")
	lowfunction.do_Infinity_pool(edit1_glo)

end

--#########################针对活动推出的大功能############################
--===1.百重塔
if main_func_glo == 8 then
	
	--这里插入动画
	Tools.GetSingleHud("百重塔开启")
	local Helper_os = false
	local Room_os = false
	for i=1,edit1_glo,1 do
		mSleep(math.random(1000,3000))
		do_ret = invoking.Game_Start(Room_os,Helper_os,false,false)
		if do_ret == 1 then --自然回体返回
			edit1_glo = edit1_glo + 1
		end
	end

end

--友情池召唤
if main_func_glo == 9 then
	Tools.GetSingleHud("南瓜村free开启")
	local Helper_os = true
	local Room_os = true
	for i=1,edit1_glo,1 do
		mSleep(math.random(1000,3000))
		do_ret = invoking.Game_Start(Room_os,Helper_os,true,false)
		if do_ret == 1 then --自然回体返回
			edit1_glo = edit1_glo + 1
		end
	end

end

--自动刷故事模式
if main_func_glo == 10 then
	Tools.GetSingleHud("友情池召唤")
	lowfunction.GetFriendShip(edit1_glo)

end


if main_func_glo == 11 then
	Tools.GetSingleHud("监狱夏日大逃脱Free开启")
	local Helper_os = true
	local Room_os = true
	local FirstFlag = 0
	--刚开始需要用户指定点击获取坐标
	--在 大地图进行
	if FirstFlag == 0 then
		w=600
		h=200
		id = createHUD()     --创建一个HUD
		showHUD(id,"请点击想要支持的队伍开启刷Free模式",36,"0xffff0000",'SingleHud.jpg',0, 100,0,w,h) 
	
		mSleep(math.random(200,500))
		TempY,TempX = catchTouchPoint(); 
		hideHUD(id)     --隐藏HUD
		sysLog("获取的点击是"..TempX..","..TempY)
		--修改全局房间表为这个坐标
		EnterRoomPoint = {TempX,720-TempY}
	end
	
	
	for i=1,edit1_glo,1 do
		
		if FirstFlag ~= 0 then
			
			mSleep(math.random(1000,2000))
			Tools.Source_Single_Click(EnterRoomPoint[1],EnterRoomPoint[2])
		end
		FirstFlag = FirstFlag + 1
		--EnterRoomPoint
		mSleep(math.random(1000,2000))
		
		do_ret = invoking.Game_Start(Room_os,Helper_os,true,false)
		if do_ret == 1 then --自然回体返回
			edit1_glo = edit1_glo + 1
		end
		
	end

end

--连续出战刷free（日服）
if main_func_glo == 12 then
	--这里插入动画
	Tools.GetSingleHud("连续出战刷free")
	local Helper_os = true
	SkipMode =  true
	local Room_os = true
	for i=1,edit1_glo,1 do
		if i > 1 then
			local Room_os = false
		end
		mSleep(math.random(1000,3000))
		do_ret = invoking.Game_Start(Room_os,Helper_os,true,false)
		ProgramSum = ProgramSum + 1 --在这里对脚本运行次数自增
		if do_ret == 1 then --自然回体返回
			edit1_glo = edit1_glo + 1
		end
	end

end
--#############################END########################################



	




--======================单独功能测试区域==============================
--invoking.FightEX()

-- lowfunction.Main_Page_confirm()
--lowfunction.Battle_Over()
--Card_Counter_table = lowfunction.Read_Card_Counter()
--output_card_table = lowfunction.Select_Card_Counter(Card_Counter_table)

-- tools.GetDeviceInfo()
--lowfunction.BaoJu_confirm(Baoju_confirm_site.one)

-- invoking.Auto_Fighting()
-- lowfunction.Read_Skill()

--自动刷剧情功能
--流程 

--===========================END=====================================





