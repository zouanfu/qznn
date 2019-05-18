local MainScene = class("MainScene",
                        function() return display.newScene("MainScene") end)

function MainScene:ctor() end

function MainScene:onEnter()
    self.ui = global:loadCsbFile(self, "res/main/MainScene.csb")

    addAnimChild(self, self.ui)
end

local animViewDataT = {}
local animViewDataB = {}

local panelChildViewT = {}
local panelChildViewB = {}

local panelChildPositionT = {}
local panelChildPositionB = {}

-- 添加动画控件
function addAnimChild(self, ui)
    local pannel = ui:getChildByName('Panel_1')
    local Panel_Girl = pannel:getChildByName('Panel_Girl')

    local Panel_2 = pannel:getChildByName('Panel_2')
    local Panel_3 = pannel:getChildByName('Panel_3')

    local Image_2 = Panel_2:getChildByName('Image_2')
    local Image_3 = Panel_3:getChildByName('Image_3')

    local Image_6 = pannel:getChildByName('Image_6')

    local Panel_6 = pannel:getChildByName('Panel_6')
    self.Panel_4 = Panel_6:getChildByName('Panel_4')
    self.Panel_4_B = Panel_6:getChildByName('Panel_4_B')

    for i = 1, 6 do
        local dataName = string.format('Panel_4_v%d', i)
        print('dataName==', dataName)
        local data = self.Panel_4:getChildByName('Panel_4_v' .. i)
        print('data:getX==', data:getPositionX())
        print('data:getY==', data:getPositionY())
        panelChildPositionT['x' .. i] = data:getPositionX()
        panelChildPositionT['y' .. i] = data:getPositionY()

        panelChildViewT[dataName] = data
    end

    for i = 1, 6 do
        local dataName = string.format('Panel_4_v%d_0', i)
        print('dataName==', dataName)
        local data = self.Panel_4_B:getChildByName('Panel_4_v' .. i .. '_0')
        print('data==', data)
        panelChildPositionB['x' .. i] = data:getPositionX()
        panelChildPositionB['y' .. i] = data:getPositionY()
        panelChildViewB[dataName] = data
    end

    -- 添加女孩和logo
    local viewGirl = MainScene:getAnimationView(homeIconGirl)
    viewGirl:setPosition(display.left + 50, display.top - 90)
    viewGirl:addTo(Panel_Girl)
    local viewLogo = MainScene:getAnimationView(homeIconLogo)
    viewLogo:setPosition(display.left + 280, 70)
    viewLogo:addTo(Panel_Girl)

    -- 添加第一页数据
    for i = 0, 5 do
        local homeIconView = MainScene:getAnimationView(
                                 homeIconPData[string.format('homeIcon%d', i)])

        if i == 5 then
            homeIconView:setPosition(-30, 295)
        else
            homeIconView:setPosition(-30, 300)
        end

        homeIconView:setScale(0.9)
        local viewPanel = panelChildViewT['Panel_4_v' .. (i + 1)]
        homeIconView:addTo(viewPanel)

        local sprite1 =
            display.newSprite("res/main/photo_level_" .. i .. ".png")
        sprite1:setPosition(95, 100)
        viewPanel:addChild(sprite1)

        local tvDZ = display.newTTFLabel(
                         {
                text = "底注:1",
                font = "Marker Felt",
                size = 17,
                color = cc.c3b(255, 255, 255),
                align = cc.TEXT_ALIGNMENT_CENTER -- 文字内部居中对齐
            })
        if i == 5 then
            tvDZ:setPosition(95, 49)
        else
            tvDZ:setPosition(95, 53.5)
        end
        viewPanel:addChild(tvDZ)

        local tvZR = display.newTTFLabel(
                         {
                text = "底注:1",
                font = "Marker Felt",
                size = 15,
                color = cc.c3b(255, 182, 194),
                align = cc.TEXT_ALIGNMENT_CENTER -- 文字内部居中对齐
            })
        if i == 5 then
            tvZR:setPosition(95, 30)
        else
            tvZR:setPosition(95, 35)
        end
        viewPanel:addChild(tvZR)

        setScaleListener(viewPanel, function() global:goPlayGameScene() end)

    end

    -- 添加第二页数据
    for i = 0, 5 do
        local homeIconView1 = MainScene:getAnimationView(
                                  homeIconPData[string.format('homeIcon%d', i)])
        if i == 5 then
            homeIconView1:setPosition(-30, 295)
        else
            homeIconView1:setPosition(-30, 300)
        end
        homeIconView1:setScale(0.9)
        local viewPanel1 = panelChildViewB['Panel_4_v' .. (i + 1) .. '_0']
        homeIconView1:addTo(viewPanel1)
        local sprite1 =
            display.newSprite("res/main/photo_level_" .. i .. ".png")
        sprite1:setPosition(95, 100)
        viewPanel1:addChild(sprite1)

        local tvDZ = display.newTTFLabel(
                         {
                text = "底注:1",
                font = "Marker Felt",
                size = 17,
                color = cc.c3b(255, 255, 255),
                align = cc.TEXT_ALIGNMENT_CENTER -- 文字内部居中对齐
            })
        if i == 5 then
            tvDZ:setPosition(95, 49)
        else
            tvDZ:setPosition(95, 53.5)
        end
        viewPanel1:addChild(tvDZ)

        local tvZR = display.newTTFLabel(
                         {
                text = "底注:1",
                font = "Marker Felt",
                size = 15,
                color = cc.c3b(255, 182, 194),
                align = cc.TEXT_ALIGNMENT_CENTER -- 文字内部居中对齐
            })
        if i == 5 then
            tvZR:setPosition(95, 30)
        else
            tvZR:setPosition(95, 35)
        end
        viewPanel1:addChild(tvZR)

        setScaleListener(viewPanel1, function() global:goPlayGameScene() end)
    end

    -- 使用第二种动画方式的时候需要开启
    for i = 1, 6 do
        self:performWithDelay(function()
            print('延时1.5秒完成')
            -- local view = panelChildViewB['Panel_4_v' .. i .. '_0']
            -- view:runAction(moveToUp)

            local moveToUp = cc.MoveTo:create(0.15, cc.p(1000, -700))
            local view = panelChildViewB['Panel_4_v' .. i .. '_0']
            view:runAction(moveToUp)

            if i == 6 then
                local moveToUp = cc.MoveTo:create(0.1, cc.p(0, -700))
                self.Panel_4_B:runAction(moveToUp)
            end
        end, i * 0.05)
    end

    setOnClickListener(Panel_2, function()
        print('点击了')
        Panel_2:setBackGroundImage('res/main/qznn_hall_tab_bg_0.png', 0)
        Panel_3:setBackGroundImage('res/main/qznn_hall_tab_bg_1.png', 0)
        Image_2:loadTexture('res/main/qznn_hall_putong_0.png', 0)
        Image_3:loadTexture('res/main/qznn_hall_mipai_1.png', 0)
        MainScene:onClickT(self)
        -- moveT(self)
    end)

    setOnClickListener(Panel_3, function()
        print('点击���222')
        Panel_2:setBackGroundImage('res/main/qznn_hall_tab_bg_1.png', 0)
        Panel_3:setBackGroundImage('res/main/qznn_hall_tab_bg_0.png', 0)
        Image_2:loadTexture('res/main/qznn_hall_putong_1.png', 0)
        Image_3:loadTexture('res/main/qznn_hall_mipai_0.png', 0)
        MainScene:onClickB(self)
        -- moveB(self)
    end)
end

function MainScene:moveT(self)
    local moveToUp = cc.MoveTo:create(0.3, cc.p(0, 0))
    self.Panel_4:runAction(moveToUp)

    local moveToUp = cc.MoveTo:create(0.3, cc.p(0, -700))
    self.Panel_4_B:runAction(moveToUp)
end

function MainScene:moveB(self)
    local moveToUp = cc.MoveTo:create(0.3, cc.p(0, 700))
    self.Panel_4:runAction(moveToUp)

    local moveToUp = cc.MoveTo:create(0.3, cc.p(0, 0))
    self.Panel_4_B:runAction(moveToUp)
end

function MainScene:onClickT(self)
    for i = 1, 6 do
        self:performWithDelay(function()
            print('延时1.5秒完成')
            -- local view = panelChildViewB['Panel_4_v' .. i .. '_0']
            -- view:runAction(moveToUp)

            local moveToUp = cc.MoveTo:create(0.15, cc.p(1000, -700))
            local view = panelChildViewB['Panel_4_v' .. (7 - i) .. '_0']
            view:runAction(moveToUp)

            if i == 6 then
                local moveToUp = cc.MoveTo:create(0.05, cc.p(0, -700))
                self.Panel_4_B:runAction(moveToUp)

                for i = 1, 6 do
                    self:performWithDelay(
                                              function()
                            print('延时1.5秒完成')
                            local moveToUp =
                                                      cc.MoveTo:create(0.15,
                                                                       cc.p(
                                                                           panelChildPositionT['x' ..
                                                                               i],
                                                                           panelChildPositionT['y' ..
                                                                               i]))
                            local view = panelChildViewT['Panel_4_v' .. i]
                            view:runAction(moveToUp)

                            if i == 6 then end
                        end, i * 0.05)
                end

            end
        end, i * 0.05)
    end
end

function MainScene:onClickB(self)
    for i = 1, 6 do
        self:performWithDelay(function()
            print('延时1.5秒完成')
            -- local view = panelChildViewB['Panel_4_v' .. i .. '_0']
            -- view:runAction(moveToUp)

            local moveToUp = cc.MoveTo:create(0.15, cc.p(0, 700))
            local view = panelChildViewT['Panel_4_v' .. i]
            view:runAction(moveToUp)

            if i == 6 then
                local moveToUp = cc.MoveTo:create(0.15, cc.p(0, 0))
                self.Panel_4_B:runAction(moveToUp)

                for i = 1, 6 do
                    self:performWithDelay(
                                              function()
                            print('延时1.5秒完成')
                            -- local view = panelChildViewB['Panel_4_v' .. i .. '_0']
                            -- view:runAction(moveToUp)

                            local moveToUp =
                                                      cc.MoveTo:create(0.15,
                                                                       cc.p(
                                                                           panelChildPositionB['x' ..
                                                                               i],
                                                                           panelChildPositionB['y' ..
                                                                               i]))
                            local view =
                                                      panelChildViewB['Panel_4_v' ..
                                                          i .. '_0']
                            view:runAction(moveToUp)

                            -- if i==6 then 
                            --     local moveToUp = cc.MoveTo:create(0.1, cc.p(0, -700))
                            --     Panel_4_B:runAction(moveToUp)   
                            -- end 
                        end, i * 0.05)
                end
            end

        end, i * 0.05)
    end
end



function MainScene:getAnimationView(resName)
    local view = dragonBones.CCFactory:buildArmatureDisplay(resName.name)
    local animation = view:getAnimation()
    animation:play(resName.action) -- 用于第一次���放

    view:addDBEventListener("loopComplete", function(event)
        -- print('播放完成')
        animation:play(resName.action)
    end)
    return view
end

function MainScene:onExit()
    print('MainScene.onExit:')
end

return MainScene
