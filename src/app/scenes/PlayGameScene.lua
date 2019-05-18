local PlayGameScene =
    class(
    'PlayGameScene',
    function()
        return display.newScene('PlayGameScene')
    end
)

function PlayGameScene:ctor()
end

function PlayGameScene:onEnter()
    self.ui = global:loadCsbFile(self, 'res/play/PlayScene.csb')
    self:initView()

    -- self:showWaitingDialog()

    -- self.gameStart = dragonBones.CCFactory:buildArmatureDisplay(gameStartAnim.name)
    -- local animation =  self.gameStart:getAnimation()
    -- animation:play(gameStartAnim.action) -- 用于第一次���放

    -- self.gameStart:addDBEventListener(
    --     'loopComplete',
    --     function(event)
    --         print('播放完成')
    --         self.gameStart:setVisible(false)
    --         self.gameStart=nil
    --         -- animation:play(gameStartAnim.action)
    --     end
    -- )
    -- self.gameStart:addTo(self):center()
end

function PlayGameScene:initView()
    local Panel_1 = self.ui:getChildByName('Panel_1')

    self.PanelUser1 = Panel_1:getChildByName('PanelUser1')
    self.PanelUser2 = Panel_1:getChildByName('PanelUser2')
    self.PanelUser3 = Panel_1:getChildByName('PanelUser3')
    self.PanelUser4 = Panel_1:getChildByName('PanelUser4')

    local Button_1 = Panel_1:getChildByName('Button_1')
    self.Panel_9 = Panel_1:getChildByName('Panel_9')
    local Panel_10 = self.Panel_9:getChildByName('Panel_10')

    local Image_16 = Panel_10:getChildByName('Image_16')
    local Text_23 = Panel_10:getChildByName('Text_23')
    local Text_24 = Panel_10:getChildByName('Text_24')
    local Text_26 = Panel_10:getChildByName('Text_26')

    self.PanelUser1:setVisible(false)
    self.PanelUser2:setVisible(false)
    self.PanelUser3:setVisible(false)
    self.PanelUser4:setVisible(false)

    setScaleListener(
        Button_1,
        function()
            global:goMainScene()
        end
    )

    setScaleListener(
        Panel_10,
        function()
            if not Text_26:isVisible() then
                Text_23:setVisible(false)
                Text_24:setVisible(false)
                Text_26:setVisible(true)
            else
                self:showWaitingDialog()
            end
        end
    )

    local countDown = 3

    self.time1 =
        self:schedule(
        function()
            print('countDown==', countDown)
            countDown = countDown - 1
            Text_23:setString('即将开始匹配...' .. countDown .. 's')
            if countDown == 0 then
                Text_23:setVisible(false)
                Text_24:setVisible(false)
                Text_26:setVisible(true)

                print('time1==', self.time1)
                self:stopAction(self.time1)
                self.time1 = nil
            end
        end,
        1
    )
end

function PlayGameScene:onEx()
end

function PlayGameScene:showWaitingDialog()
    self.PanelUser1:setVisible(true)
    local dialgo = global:loadCsbFile(self, 'res/play/DialogWaiting.csb')
    print('dialog:', dialgo)
    local panel = dialgo:getChildByName('Panel_2')
    -- -- 移动动画
    -- dialgo.fadeIn(panel, 0.8)
    action.fadeIn(panel, 0.5)
    -- -- 文本内容  点点点的动画
    local Text_cotent = panel:getChildByName('Text_2_0')

    local num = 1
    local count = 6

    -- -- 定时器
    self.scheduler =
        self:schedule(
        function()
            local text = num % 4
            if text == 0 then
                Text_cotent:setString('游戏即将开始,请耐心等待.')
            elseif text == 1 then
                Text_cotent:setString('游戏即将开始,请耐心等待..')
            elseif text == 2 then
                Text_cotent:setString('游戏即将开始,请耐心等待...')
            else
                Text_cotent:setString('游戏即将开始,请耐心等待....')
            end
            if num >= count then
                print('停止定时器，并关闭弹窗')
                self:stopAction(self.scheduler)
                dialgo.fadeOut(panel, 0.4)
                dialgo:setVisible(false)
                dialgo = nil
                self.scheduler = nil

                self.Panel_9:setVisible(false)
                self.PanelUser2:setVisible(true)
                self.PanelUser3:setVisible(true)
                self.PanelUser4:setVisible(true)

                self.gameStart =
                    AppUtils:getAnimationView(
                    gameStartAnim,false,
                    function()
                        print('回调')
                        self.gameStart:setVisible(false)
                        self.gameStart = nil
                    end
                )
                self.gameStart:addTo(self):center()
            end
            num = num + 1
        end,
        0.5
    )

    -- 离开按钮
    -- local Image_close = panel:getChildByName('Image_close')
    -- Image_close:addTouchEventListener(
    --     function(callBack, event)
    --         if event == 2 then
    --             print('点击关闭===========')
    --             dialgo.fadeOut(panel, 0.4)
    --             dialgo = nil
    --             self.scheduler = nil
    --         end
    --     end
    -- )
end

function getAnimationView(resName, count, callback)
    local startCount = 1
    local view = dragonBones.CCFactory:buildArmatureDisplay(resName.name)
    local animation = view:getAnimation()
    animation:play(resName.action) -- 用于第一次���放
    view:addDBEventListener(
        'loopComplete',
        function(event)
            print('event==', event)
            -- print('event==', json.encode(event))
            -- print('event==', animation:getState())
            callback()
            -- self:stopAnimation()
            -- view=nil
            -- animation=nil
            -- print('播放完成')
            -- animation:stopAnimation()
            -- if count == 0 then
            --     animation:play(resName.action)
            --     return
            -- elseif count > 1 and startCount < count then
            --     animation:play(resName.action)
            --     startCount = startCount + 1
            -- end
        end
    )
    return view
end

return PlayGameScene
