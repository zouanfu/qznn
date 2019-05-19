----------------------------------------------------------------------------------------------------------------
-- global 全局类
----------------------------------------------------------------------------------------------------------------
global = {}

local ImageLoader = require('app.utils.ImageLoader')

-- 调试log
function global:log(...)
    if DEBUG == 1 then
        print(...)
    end
end

-- 播放按钮音效
function global:playButtonEffect()
    audio.loadFile(
        EFFECT_BUTTON,
        function(path, isLoadedSuccess)
            if isLoadedSuccess then
                audio.playEffect(EFFECT_BUTTON, false)
            end
        end
    )
end

-- 设置随机数种子
function global:setRandSeed()
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
end

-- 加载并解析UI文件
-- scene 要添加的场景
-- jsonFile UI文件
function global:loadCCSJsonFile(scene, jsonFile)
    local node, width, height = cc.uiloader:load(jsonFile)
    width = width or display.width
    height = height or display.height
    if node then
        node:setPosition((display.width - width) / 2, (display.height - height) / 2)
        scene:addChild(node)
        return node
    end
end

-- 加载并解析csb文件
-- scene 要添加的场景
-- csd UI文件
function global:loadCsbFile(scene, csb)
    local node = cc.CSLoader:createNode(csb)
    width = CONFIG_SCREEN_WIDTH
    height = CONFIG_SCREEN_HEIGHT
    if node then
        node:setPosition((display.width - width) / 2, (display.height - height) / 2)
        scene:addChild(node)
        return node
    end
end

-- 去推广界面
function global:goExtensionScene()
    display.replaceScene(require('app.scenes.ExtensionScene').new(), 'moveInR', GAME_ACT_TIME)
end

-- 去活动界面
function global:goActivityScene()
    -- moveInL
    -- fade
    display.replaceScene(require('app.scenes.ActivityScene').new(), 'moveInL', GAME_ACT_TIME)
end

-- 去主界面2
function global:goMainScene2(data)
    display.replaceScene(require('app.scenes.MainScene').new(data))
end

-- 去主界面
function global:goMainScene()
    -- moveInL
    -- fade
    display.replaceScene(require('app.scenes.MainScene').new(), 'moveInL', GAME_ACT_TIME)
end

function global:goPlayGameScene()
    display.replaceScene(require('app.scenes.PlayGameScene').new(), 'moveInL', GAME_ACT_TIME)
end

-- 去洗码界面
function global:goWashCodeScene()
    display.replaceScene(require('app.scenes.WashCodeScene').new(), 'moveInL', GAME_ACT_TIME)
end

-- 去客服界面
function global:goCustomerScene()
    display.replaceScene(require('app.scenes.CustomerScene').new(), 'moveInL', GAME_ACT_TIME)
end

-- 去消息界面
function global:goEmailScene()
    -- moveInL
    -- fade
    display.replaceScene(require('app.scenes.EmailScene').new(), 'moveInL', GAME_ACT_TIME)
end

-- 去充值界面
function global:goRechargeScene()
    display.replaceScene(require('app.scenes.RechargeScene').new(), 'moveInL', GAME_ACT_TIME)
end

-- 去提现界面
function global:goWithdrawScene()
    display.replaceScene(require('app.scenes.WithdrawScene').new(), 'moveInL', GAME_ACT_TIME)
end

-- 删除纹理缓冲
function global:removeAllTextures()
    cc.Director:getInstance():getTextureCache():removeAllTextures()
    cc.Director:getInstance():getTextureCache():removeUnusedTextures()
end

-- 复制到剪贴板
function global:copyToClipboard(message)
    if device.platform == 'ios' then
        local args = {text = message}
        luaoc.callStaticMethod('CustomFunc', 'copyToClipboard', args)
    elseif device.platform == 'android' then
        local className = 'org/cocos2dx/lua/AppActivity'
        luaj.callStaticMethod(className, 'copyToClipboard', args)
    end
    hud.showHud('复制成功')
end

-- lua字符串分割
function global:split(str, reps)
    local resultStrList = {}
    string.gsub(
        str,
        '[^' .. reps .. ']+',
        function(w)
            table.insert(resultStrList, w)
        end
    )
    return resultStrList
end

-- url   请求链接 "https://p.ssl.qhimg.com/dmfd/400_300_/t0120b2f23b554b8402.jpg"
-- name  消息的名字
-- callback(tex) 消息回调，返回图片tex
function global:requestImageLoader(url, name, callback)
    ImageLoader.new(url, 'bg'):saveTo(device.writablePath .. 'cache' .. device.directorySeparator):onSuccess(
        function(tex, id)
            if id == name then
                -- cc.Sprite:createWithTexture(tex):center():addTo(self)
                callback(tex)
            end
        end
    ):execute()
end

-- 设置点击事件
function setOnClickListener(view, callBackFunc)
    print('view===',view)
    view:addTouchEventListener(
        function(callback, event)
            -- 抬起或去取消的时候才回调点击
            if event == 2 or event == 3 then
                callBackFunc()
            end
        end
    )
end

-- 点击缩小 松开放大
function setScaleListener(view, callBackFunc)
    view:addTouchEventListener(
        function(callback, event)
            print('callBack', callback)
            print('event', event)
            if event == 0 then
                global:viewScale(view, true)
            elseif event == 2 or event == 3 then
                global:viewScale(view, false)
                if event == 2 then
                    callBackFunc()
                end
            end
        end
    )
end

function global:viewScale(view, isScale)
    if isScale then
        view:setScale(0.9)
    else
        view:setScale(1)
    end
end

return global
