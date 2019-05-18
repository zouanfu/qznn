--[[ 
    使用方法
    ImageLoader.new("https://p.ssl.qhimg.com/dmfd/400_300_/t0120b2f23b554b8402.jpg", "bg")
    :saveTo(device.writablePath .. "cache" .. device.directorySeparator)
    :onSuccess(function(tex, id)
        if id == "bg" then
            cc.Sprite:createWithTexture(tex):center():addTo(self)
        end
    end):execute()
--]]
local ImageLoader = class("ImageLoader")

--[[构造函数
    url:网络路径
    id:任务id，用于回调时区分任务
--]]
function ImageLoader:ctor(url, id)
    self.url = url
    self.id = id
    self.path = path or (device.writablePath .. "cache" .. device.directorySeparator)   
    self.status = "wait"

    --创建默认缓存路径
    local isDirExist = cc.FileUtils:getInstance():isDirectoryExist(self.path)
    if not isDirExist then
        cc.FileUtils:getInstance():createDirectory(self.path)
    end
end

--设置存储路径，需在execute之前执行
function ImageLoader:saveTo(path)
    self.path = path
    return self
end

--设置加载成功后的回调
function ImageLoader:onSuccess(func)
    self.onSuccessFunc = func
    return self
end

--设置加载失败后的回调
function ImageLoader:onError(func)
    self.onErrorFunc = func
    return self
end

--图片加载任务执行
function ImageLoader:execute()
    self.status = "process"

    --1.设置文件缓存路径
    if not self.url then return self end
    local path = self.path .. crypto.md5(self.url)

    --2.从纹理缓存中加载
    local tex = cc.Director:getInstance():getTextureCache():getTextureForKey(path)
    if tex then
        self:callback(tex)
        return self
    end

    --3.从本地资源中加载
    local isExist = cc.FileUtils:getInstance():isFileExist(path)
    if isExist then
        cc.Director:getInstance():getTextureCache():addImageAsync(path, function (tex)
            self:callback(tex)
        end)
        return self
    end 

    --4.从网络中加载
    network.createHTTPRequest(function(evt)
        if evt.name == "progress" then
            return self
        end             

        --fail
        if evt.name ~= "completed" then
            local errorCode = evt.request:getErrorCode()
            local errorMsg = evt.request:getErrorMessage()
            self:callbackErr(errorCode, errorMsg)
            return self
        end

        --error
        local statusCode = evt.request:getResponseStatusCode()
        if statusCode ~= 200 then
            self:callbackErr(statusCode)
            return self
        end

        --访问成功，写入本地文件
        local reqData = evt.request:getResponseData()
        io.writefile(path, reqData, "w+b")      
        tex = cc.Director:getInstance():getTextureCache():addImage(path)
        self:callback(tex)       

    end, self.url, "GET"):start()

    return self
end

--加载成功后的回调
function ImageLoader:callback(tex)
    self.tex = tex
    self.status = "success"
    if self.onSuccessFunc then
        self.onSuccessFunc(tex, self.id)
    end
end

--加载失败后的回调
function ImageLoader:callbackErr(errCode, msg)    
    self.errCode = errCode
    self.msg = msg
    self.status = "error"
    if self.onErrorFunc then
        self.onErrorFunc(errCode, msg)
    end
end

return ImageLoader