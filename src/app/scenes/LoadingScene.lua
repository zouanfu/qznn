local LoadingScene =
    class(
    'LoadingScene',
    function()
        return display.newScene('LoadingScene')
    end
)

local animationData = {}

function LoadingScene:ctor()
end

function LoadingScene:onEnter()
    self.value = 0
    self.isRequestSucceed = false

    addAnimaData()
    addAnimDataToDragon()

    self.ui = global:loadCsbFile(self, 'res/loading/LoadingSecene.csb')
    local Panel_2 = self.ui:getChildByName('Panel_2')
    local Panel_4 = Panel_2:getChildByName('Panel_4')
    local Panel_3 = Panel_2:getChildByName('Panel_3')
    local Panel_1 = Panel_3:getChildByName('Panel_1')
    local LoadingBar_1 = Panel_3:getChildByName('LoadingBar_1')
    local tvProgress = Panel_3:getChildByName('Text_1')

    local sprite = addSpriteAnim()
    sprite:setPosition(562, 80)
    Panel_1:addChild(sprite)

    LoadingBar_1:setPercent(self.value)
    tvProgress:setString('0%')

    local db = dragonBones.CCFactory:buildArmatureDisplay(girl.name)
    self.db = db
    if db ~= nil then
        local ani = db:getAnimation()
        ani:play(girl.action) -- 用于第一次播放
        db:setPosition(display.left, display.top - 30)
        db:addTo(Panel_4)
    end
    self.timer =
        self:schedule(
        function()
            if self.value >= 90 then
                -- if self.isRequestSucceed then
                --     self.value = self.value + math.random(0, 3)
                -- else
                --     self.value = 90
                -- end
                if not self.isRequestSucceed then
                    self:performWithDelay(
                        function()
                            self.value = self.value + math.random(0, 3)
                        end,
                        1.5
                    )
                -- self.isRequestSucceed = true
                end

                if self.value >= 100 then
                    print('定时器停止，进入首页')
                    if self.timer ~= nil then
                        self:stopAction(self.timer)
                    end
                    global:goMainScene()
                    -- global:goPlayGameScene()
                end
            else
                self.value = self.value + math.random(0, 5)
            end

            LoadingBar_1:setPercent(self.value)
            tvProgress:setString(self.value > 100 and 100 .. '%' or self.value .. '%')
        end,
        0.05
    )

    function getDataSucceed()
        print('请求成功')
    end

    function getDataFiald()
        print('请求失败')
    end

    self:getHomeData(getDataSucceed, getDataFiald)
end

function LoadingScene:getHomeData(succeed, faild)
    function succeed(jsonData)
    end

    function faild()
    end

    local request = networkManage.getRequest(succeed, faild, HALL_URL)
    request:start()
end

function sleep(n)
    local socket = require('socket')
    socket.select(nil, nil, n)
end

function addAnimDataToDragon()
    print('添加动画资源文件到dragon,app._isLoaded=', app._isLoaded)
    -- 动画资源加载的时候不能重复，如果重复了会报错
    if not app._isLoaded then
        print('加载之前先全清除已加载的资源')
        dragonBones.CCFactory:clear()
        for i, tab in pairs(animationData) do
            print(i, tab)
            local ste = string.format('res/dragonAnim/%s' .. '.json', tab.ske)
            local tex = string.format('res/dragonAnim/%s' .. '.json', tab.tex)
            dragonBones.CCFactory:loadDragonBonesData(ste)
            dragonBones.CCFactory:loadTextureAtlasData(tex)
        end
        app._isLoaded = true
    end
end

local isLoadAnim = false

function addSpriteAnim()
    if not isLoadAnim then
        -- 只加载一次
        display.addSpriteFrames('res/loading/loadingSprite.plist', 'res/loading/loadingSprite.png')
        isLoadAnim = true
    end

    local frames = display.newFrames('mainhall_effect_lvnotic_%d.png', 0, 14)
    local animation = display.newAnimation(frames, 0.2)
    local count = #frames
    local animation = cc.Animation:createWithSpriteFrames(frames, 0.2, -1)
    local animate = cc.Animate:create(animation)
    local sprite = display.newSprite('#mainhall_effect_lvnotic_0.png')

    local fu =
        cc.CallFunc:create(
        function()
            print('结束动画')
        end
    )
    local seq = cc.Sequence:create(animate, fu)

    print('开始动画')
    sprite:runAction(seq)

    -- display.addSpriteFrames('res/loading/loadingSprite.plist', 'res/loading/loadingSprite.png') --添加帧缓存
    -- local sp = display.newSprite('#mainhall_effect_lvnotic_0.png')
    -- -- self:addChild(sp)
    -- local frames = display.newFrames('mainhall_effect_lvnotic_%d.png', 0, 14)
    -- local animation = display.newAnimation(frames, 2.8 / 14.0)
    -- local animate = cc.Animate:create(animation)
    -- -- display.setAnimationCache("Walk", animation)
    -- -- -- sp:runAction(animation)
    -- Sprite:playAnimationOnce(display.getAnimationCache("Walk"))

    -- transition.playAnimationOnce(target, animation, removeWhenFinished, onComplete, delay)

    -- print('animation==',animation)
    -- -- sp:runAction(animate) -- 播放一次动画

    return sprite
end

function exe()
    display.addSpriteFrames('loadingSprite.plist', 'loadingSprite.png')

    local frames = display.newFrames('mainhall_effect_lvnotic_%d.png', 2, 29)
    local animation = display.newAnimation(frames, 0.2)
    local animate = cc.Animate:create(animation)
    local sprite = display.newSprite('#mainhall_effect_lvnotic_2.png')
    sprite:setPosition(480, 320)
    sprite:addChild(sprite)
    sprite:runAction(animate)
end

function addAnimaData()
    print('添加动画资源文件到table')

    animationData['girl'] = girl
    animationData['homeIconGirl'] = homeIconGirl
    animationData['homeIconLogo'] = homeIconLogo
    animationData['homeIcon0'] = homeIcon0
    animationData['homeIcon1'] = homeIcon1
    animationData['homeIcon2'] = homeIcon2
    animationData['homeIcon3'] = homeIcon3
    animationData['homeIcon4'] = homeIcon4
    animationData['homeIcon5'] = homeIcon5
    animationData['gameStartAnim'] = gameStartAnim
end

return LoadingScene
