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
    self:serviceCardView()
  
end

function PlayGameScene:initView()
    local Panel_1 = self.ui:getChildByName('Panel_1')

    self.PanelUser1 = Panel_1:getChildByName('PanelUser1')
    self.PanelUser2 = Panel_1:getChildByName('PanelUser2')
    self.PanelUser3 = Panel_1:getChildByName('PanelUser3')
    self.PanelUser4 = Panel_1:getChildByName('PanelUser4')

    local Panel_2 = Panel_1:getChildByName('Panel_2')
    local Panel_2_0 = Panel_1:getChildByName('Panel_2_0')
    local Panel_2_1 = Panel_1:getChildByName('Panel_2_1')
    local Panel_2_2 = Panel_1:getChildByName('Panel_2_2')

    local cardPosition1X = Panel_2_1:getPositionX()
    local cardPosition1Y = Panel_2_1:getPositionY()
    locationList[1] = {x = cardPosition1X, y = cardPosition1Y}

    local cardPosition2X = Panel_2_2:getPositionX()
    local cardPosition2Y = Panel_2_2:getPositionY()
    locationList[4] = {x = cardPosition2X, y = cardPosition2Y}

    local cardPosition3X = Panel_2_0:getPositionX()
    local cardPosition3Y = Panel_2_0:getPositionY()
    locationList[3] = {x = cardPosition3X, y = cardPosition3Y}

    local cardPosition4X = Panel_2:getPositionX()
    local cardPosition4Y = Panel_2:getPositionY()
    locationList[2] = {x = cardPosition4X, y = cardPosition4Y}

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

cardViewList = {}
locationList = {}
function PlayGameScene:pushCardAnim()
    if cardViewList then
        cardViewList = {}
    end
    for i = 1, 20 do
        local sprite1 = display.newSprite('res/card/card_effect_fanpai5_0.png')
        sprite1:setScale(0.4)
        sprite1:center()
        sprite1:addTo(self):center()
        table.insert(cardViewList, sprite1)
        -- local contentSize = sprite1:getContentSize()
        -- cardViewList.insert(tablename, pos, value)
    end

    for k, v in pairs(cardViewList) do
        print(k, v)
        if k >= 1 and k < 6 then
            self:playAnimationOneUser(v, k, 1)
        elseif k >= 6 and k < 11 then
            self:playAnimationOne(v, k, 2)
        elseif k >= 11 and k < 16 then
            self:playAnimationOne(v, k, 3)
        elseif k >= 16 then
            self:playAnimationOne(v, k, 4)
        end
    end
end

UserCardView = {}
-- 模拟服务器返回的卡牌 用table保存起来
function PlayGameScene:serviceCardView()
    -- 假如当前用户卡牌为:2JQKA,分别为黑桃，红桃，梅花，方块，黑桃,创建view并保存
    print('userCard111', CardListData:getCardData(1, 1))
    -- res/card/mpnn_effect_1.png
    local userCard1 = display.newSprite(CardListData:getCardData(1, 1))

    userCard1:setScale(0.4)
    userCard1:center()

    local userCard2 = display.newSprite(CardListData:getCardData(2, 10))
    userCard2:setScale(0.4)
    userCard2:center()

    local userCard3 = display.newSprite(CardListData:getCardData(3, 11))
    userCard3:setScale(0.4)
    userCard3:center()

    local userCard4 = display.newSprite(CardListData:getCardData(4, 12))
    userCard4:setScale(0.4)
    userCard4:center()

    local userCard5 = display.newSprite(CardListData:getCardData(1, 13))
    userCard5:setScale(0.4)
    userCard5:center()

    UserCardView[1] = CardListData:getCardData(1, 1)
    UserCardView[2] = CardListData:getCardData(2, 10)
    UserCardView[3] = CardListData:getCardData(3, 11)
    UserCardView[4] = CardListData:getCardData(4, 12)
    UserCardView[5] = CardListData:getCardData(1, 13)
end

-- 第一种动画 发牌
function PlayGameScene:playAnimationOne(view, position, typePosi)
    -- statements
    self:performWithDelay(
        function()
            print('定时器')
            print('view===', position)
            local startIndex = 1
            if typePosi == 1 then
                startIndex = 1
            elseif typePosi == 2 then
                startIndex = 6
            elseif typePosi == 3 then
                startIndex = 11
            elseif typePosi == 4 then
                startIndex = 16
            end
            local xInd = 0
            if position > startIndex then
                xInd = self:getCardX(startIndex, position - 1)
            end
            print('xInd==', xInd)
            local moveOne =
                cc.MoveTo:create(
                0.5,
                cc.p(locationList[typePosi].x + (40 + (xInd or 0)), locationList[typePosi].y + 50)
            )
            local scaleOne = cc.ScaleTo:create(0.5, 0.6)
            view:runAction(scaleOne)
            view:runAction(moveOne)

            self:playAnimationTwo(position)
        end,
        position * 0.1
    )
end

function PlayGameScene:playAnimationOneUser(view, position, typePosi)
    -- statements
    self:performWithDelay(
        function()
            print('定时器')
            print('view===', position)
            local startIndex = 1
            if typePosi == 1 then
                startIndex = 1
            elseif typePosi == 2 then
                startIndex = 6
            elseif typePosi == 3 then
                startIndex = 11
            elseif typePosi == 4 then
                startIndex = 16
            end
            local xInd = 0
            if position > startIndex then
                xInd = self:getCardX(startIndex, position - 1)
            end
            print('locationList[typePosi].x + (40 + (xInd or 0)==', locationList[typePosi].x + (40 + (xInd or 0)))
            print('locationList[typePosi].y + 50', locationList[typePosi].y + 50)
            local moveOne =
                cc.MoveTo:create(
                0.5,
                cc.p(locationList[typePosi].x + (40 + (xInd or 0)), locationList[typePosi].y + 50)
            )
            local scaleOne = cc.ScaleTo:create(0.5, 1)
            view:runAction(scaleOne)
            view:runAction(moveOne)

            self:playAnimationTwo(position)
        end,
        position * 0.1
    )
end

-- 发牌动作完成之后在播放这种动画，每张牌x轴平移一小段位置
function PlayGameScene:playAnimationTwo(position)
    local getIndex = 0
    if position == 5 then
        getIndex = 0
        self:performWithDelay(
            function()
                print('0.5倒计时到了，')
                self:showMeCard()
            end,
            0.6
        )
        -- self:playAnimationTwoUser(position)
        return
    end
    if position == 10 then
        getIndex = 5
    end
    if position == 15 then
        getIndex = 10
    end
    if position == 20 then
        getIndex = 15
    end

    if position == 5 or position == 10 or position == 15 or position == 20 then
        for i = 1, 5 do
            self:performWithDelay(
                function()
                    local cardView = cardViewList[i + getIndex]
                    local xInd = 0
                    if i > 1 then
                        xInd = self:getCardX(0, i - 1, 20)
                        local moveOne =
                            cc.MoveTo:create(
                            0.5,
                            cc.p((cardView:getPositionX() + (xInd or 0)), cardView:getPositionY())
                        )
                        cardView:runAction(moveOne)
                    end
                end,
                i * 0.1
            )
        end
    end
end

function PlayGameScene:playAnimationTwoUser(position)
    -- statements
    for i = 1, 5 do
        self:performWithDelay(
            function()
                local cardViewZero = self.userCardView[1]
                local cardView = self.userCardView[i]

                local contentSize = cardView:getContentSize()
                print('height:', contentSize.height)
                print('width:', contentSize.width)

                local xInd = 0
                if i > 1 then
                    xInd = self:getCardX(0, i - 1, 20)
                    print('用户发牌xInd==', xInd)
                    local moveOne =
                        cc.MoveTo:create(
                        0.5,
                        cc.p(
                            (cardViewZero:getPositionX() + contentSize.width*0.4 * (i - 1) - xInd),
                            cardView:getPositionY()
                        )
                    )
                    cardView:runAction(moveOne)
                end
            end,
            i * 0.1
        )
    end
end

-- 显示我的卡牌
function PlayGameScene:showMeCard()
    local cardViewZero = cardViewList[1]
    local contentSize = cardViewZero:getContentSize()
    self.userCardView = {}
    print('cardViewZero:getPositionX():', cardViewZero:getPositionX())
    print('cardViewZero:getPositionY():', cardViewZero:getPositionY())

    for key, value in pairs(UserCardView) do
        cardViewList[key]:setVisible(false)
        -- statements
        print(key, value)
        local sprite1 = display.newSprite(value)

        local xInd = 0
        if key > 1 then
            xInd = self:getCardX(0, key - 1, 30)
        end
        print('xInd===', xInd)
        sprite1:setPosition(cardViewZero:getPositionX() + xInd, cardViewZero:getPositionY())
        sprite1:scale(0.3)
        -- value:addTo(self):center()
        sprite1:addTo(self)
        self.userCardView[key] = sprite1
    end

    self:playAnimationTwoUser()
end

-- 获取需要平移的距离
function PlayGameScene:getCardX(baseIndex, index, multiply)
    if not baseIndex then
        return
    end
    if not index then
        return
    end
    if not multiply then
        multiply = 10
    end
    -- statements
    local posi = index - baseIndex
    return posi * multiply
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
                    gameStartAnim,
                    false,
                    function()
                        print('回调')
                        self.gameStart:setVisible(false)
                        self.gameStart = nil

                        self:pushCardAnim()
                    end
                )
                self.gameStart:addTo(self):center()
            end
            num = num + 1
        end,
        0.5
    )
end

return PlayGameScene
