----------------------------------------------------------------------------------------------------------------
-- 游戏动作类
----------------------------------------------------------------------------------------------------------------

action = {}

--[[
	<菜单效果-移动效果>
	@param obj      播放的对象
	@param duration 播放时间长达(秒)
--]]
function action.move(obj,x,y,duration)
	local fadeIn = cc.FadeIn:create(duration / 2)
	local move   = cc.MoveTo:create(duration,cc.p(x,y))
	local ebIo     = cc.EaseBackInOut:create(move)
	obj:runAction(ebIo)
	obj:runAction(fadeIn)
end

--[[
	<菜单效果-果冻弹出效果>
	@param obj      播放的对象
	@param duration 播放时间长达(秒)
--]]
function action.pop(obj,duration)
	local  size = obj:getScale()
	local progress_1 = cc.ScaleTo:create(duration / 5,size +  0.05)
	local progress_2 = cc.ScaleTo:create(duration / 5,size -  0.05)
	local progress_3 = cc.ScaleTo:create(duration / 5,size + 0.025)
	local progress_4 = cc.ScaleTo:create(duration / 5,size - 0.025)
	local progress_5 = cc.ScaleTo:create(duration / 5,size)
	local seq   = cc.Sequence:create(progress_1,progress_2,progress_3,progress_4,progress_5)
	obj:runAction(seq)
end

--[[
	<菜单效果-淡入效果>
	弹出式菜单->从屏幕底部看不见位置移动(同时播放淡入效果)到屏幕中央的位置
	@param obj      播放的对象
	@param duration 播放时间长达(秒)
--]]
function action.fadeIn(obj,duration)
	obj:setOpacity(0)
	obj:setAnchorPoint(cc.p(0.5,0.5))
	obj:setPosition(cc.p(display.width / 2, -display.height))
	local fadeIn  = cc.FadeIn:create(duration)
	obj:runAction(fadeIn)
	local move = cc.MoveTo:create(duration,cc.p(display.width / 2,display.height / 2))
	obj:runAction(move)
end

--[[
	<菜单效果-淡淡出效果>
	弹出式菜单->从屏幕中央位置移动(同时播放淡出效果)到屏幕底部看不见的位置
	@param obj      播放的对象
	@param duration 播放时间长达(秒)
--]]
function action.fadeOut(obj,duration)
	obj:setOpacity(255)
	obj:setAnchorPoint(cc.p(0.5,0.5)) 
	obj:runAction(cc.FadeOut:create(duration))
	obj:runAction(cc.MoveTo:create(duration,cc.p(display.width / 2, -display.height)))
end



