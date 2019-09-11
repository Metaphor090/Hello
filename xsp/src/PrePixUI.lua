require("Z_ui")
require("base")
function GetUI()
	DevScreen={--开发设备的参数
		Width=1280,--注意Width要大于Height,开发机分辨率是啥就填啥
		Height=720 --注意Width要大于Height,开发机分辨率是啥就填啥
	}
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	
	--主UI面板设置
	local myui=UI:new(DevScreen,{align="left",w=90,h=90,size=40,cancelname="取消",okname="OK",countdown=999,config="配置切换.dat",bg="bg.jpg"})--在page中传入的size会成为所有page中所有控件的默认字体大小,同时也会成为所有page控件的最小行距
	
	--页面设置 ,size=20    ,xpos=0 横坐标间距
	local mypage1=Page:new(myui,{text="配置切换"})--在page中传入的size会成为page中所有控件的默认字体大小,同时也会成为page控件的最小行距(覆盖UI中的size设置)
	
	--获取当前所有配置文件信息
	mypage1:addLabel({text="言成吉ACG温馨提示:",color="255,0,0"})
	--mypage1:addQQ({text="496220561"})
	mypage1:nextLine()
	mypage1:addLabel({text="需要试用请进qq群982851320联系群主获取测试激活码",color="255,0,0"})
	mypage1:nextLine()

	mypage1:addLabel({text="当前已适配三服的最新活动~",color="255,0,0"})
	mypage1:nextLine()
	mypage1:addLabel({text="日服：新剧情长草。。。",color="65,105,225",size=30})
	mypage1:nextLine()
	
	mypage1:addLabel({text="国服：三期泳装",color="65,105,225",size=30})
	mypage1:nextLine()
	mypage1:addLabel({text="台服：空境复刻",color="65,105,225",size=30})
	mypage1:nextLine()
	mypage1:addLabel({text="激活码",color="65,105,225",size=30})
	mypage1:nextLine()
	mypage1:addEdit({id="激活码",prompt="请粘贴您购买的激活码~",text="",color="65,105,225",w=100,h=15})
	mypage1:nextLine()
	mypage1:addLabel({text="您当前选择的配置文件是~"})
	mypage1:addComboBox({id="配置切换",list="配置一,配置二,配置三,配置四,配置五",w=23,h=10,size=20,color="65,105,225"})
	mypage1:nextLine()
	
	
	--mypage4:addCheckBoxGroup({id="多选2",list="多选选项21,多选选项22,多选选项23",select="3",w=70,h=10,color="255,0,0"})
	--单项多选框第三种返回值模式的特殊操作,用于仅有一个选项的多选框,创建时额外传入一个参数a,a可以是不为nil或false的任意值
	--mypage4:addCheckBoxGroup({a=1,id="单项多选框",list="单项多选框",select="0",w=70,h=10,color="255,0,0"})
	--mypage4:addComboBox({id="下拉2",list="下拉选项21,下拉选项22,下拉选项23",select=0,w=70,h=10})
	
	--获取myui
	
	
	return myui
	
	
end

return GetUI