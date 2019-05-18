
require("config")
require("cocos.init")
require("framework.init")
require("app.utils.global")
require("app.network.networkManage")
require("app.constants.Api")
require("app.constants.Audio")
require("app.constants.AnimtionData")
require("app.constants.CardListData")

require("app.utils.action")
require("app.utils.AppUtils")


local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    -- self:enterScene("LoadingScene")
    self:enterScene("PlayGameScene")

end

return MyApp
