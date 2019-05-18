-- 和本app业务逻辑相关的一些常用方法
AppUtils = {}

-- 根据龙骨资源名字获取龙骨view，和AnimtionData文件相关
--startCount播放次数 0循环   这个循环次数没用 直接在ske json文件中修改playTimes字段
function AppUtils:getAnimationView(resName, isLoop, callback)
    local startCount = 1
    local view = dragonBones.CCFactory:buildArmatureDisplay(resName.name)
    local animation = view:getAnimation()
    animation:play(resName.action) -- 用于第一次���放
    view:addDBEventListener(
        'loopComplete',
        function(event)
            -- print('播放完成')
            if isLoop then
                animation:play(resName.action)
            else
                callback()
            end
            --todo
        end
    )
    return view
end
