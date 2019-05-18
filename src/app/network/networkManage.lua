--
-- Author: Luke
-- Date: 2019-05-06 16:02:23
--

networkManage = {}

-- 判断网络是否可用
function networkManage.isInternetConnectionAvailable()
    return network:isLocalWiFiAvailable() or network.isInternetConnectionAvailable()
end

function networkManage.getAuthRequest(success, failed, url)
	local request = networkManage.request(success, failed, url, "GET")
	request:addRequestHeader("Authorization:"..user.token())
	request:start()
    return request
end

function networkManage.getRequest(success, failed, url)
	print("Get网络请求")
	return networkManage.request(success, failed, url, "GET")
end

function networkManage.postRequest(success, failed, url)
	print("Post网络请求")
	local request = networkManage.request(success, failed, url, "POST")
	-- request:addRequestHeader("Content-Type:application/x-www-form-urlencoded")
	return request
end

function networkManage.request(success, failed, url, method)
	local callback = function ()
		return function ()
			return networkManage.request(success, failed, url, method)
		end
	end
	if not networkManage.isInternetConnectionAvailable() then
		networkManage.showHud(502, callback())
		return
	end
	networkManage.showActivityIndicator()
	local request = network.createHTTPRequest(function(event)
		if event.name == "failed" then
			if failed then
				failed()
			end
			networkManage.hideActivityIndicator()
			networkManage.showHud(502, callback())
			return
	    end
		local ok = (event.name == "completed")
		local request = event.request
		if not ok then
			return
		end
		local code = request:getResponseStatusCode()
		if code ~= 200 then
			if failed then
				failed()
			end
			networkManage.hideActivityIndicator()
			networkManage.showHud(502, callback())
			return
		end
		networkManage.hideActivityIndicator()
		local response = request:getResponseString()
		local jsonData = json.decode(response)
		print(jsonData.status)
	    if jsonData.result and jsonData.result ~= "" then
	    	if failed then
	    		failed()
	    	end
	    	hud.showHud(jsonData.result)
	    elseif jsonData.status == 502 or jsonData.status == 9999 then
	    	if failed then
				failed()
	    	end
			networkManage.showHud(jsonData.status, callback())
		elseif jsonData.status == 404 then
			if failed then
				failed()
	    	end
			networkManage.showHud(jsonData.status, nil)
		elseif jsonData.status == 2 then -- 未登录 自动登录

		elseif jsonData.status == 3 then --账号在其他地方登录了

	    elseif jsonData.status == 0 then
	    	if failed then
	    		failed()
	    	end
	    	hud.showHud(jsonData.msg)
	    elseif jsonData.status == 1 and success then
	    	success(jsonData.data)
	    end
	end, url, method)
	return request
end

function networkManage.showHud(statusCode, callback)
	if statusCode == 502 or statusCode == 9999 then
		print("服务器异常：502")
		-- hud.networkHud(statusCode, callback)
		return
	end
	if statusCode == 404 then
		hud.showHud("请求不存在")
		return
	end
	hud.showHud(message)
end

function networkManage.showActivityIndicator()
	device.showActivityIndicator()
end

function networkManage.hideActivityIndicator()
	device.hideActivityIndicator()
end

return networkManage