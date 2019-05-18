----------------------------------------------------------------------------------------------------------------
-- 网络字符自定义类
----------------------------------------------------------------------------------------------------------------

BASE_URL = "http://newh5.430v.com/"--"http://newh5.430v.com/"
-- http://js.430v.com/
-- http://js.430v.com/member/gamingPlatfrom/findGamingPlatfromListSort

-- 首页信息获取
HALL_URL =  BASE_URL .. "member/gamingPlatfrom/findGamingPlatfromList"

-- 用户登录 post
LOGIN_URL = BASE_URL .. "member/memberManager/login"

-- 账户注册 post
REGISTER_ACCOUNT_URL = BASE_URL .. "member/memberManager/registered"

-- 注册配置信息获取
REGISTER_CONFIG_URL = BASE_URL .. "member/memberManager/selectMemberRegisterInfo?indx=1&index2=3"

-- 验证码图片请求
REGISTER_CODE_URL = BASE_URL .. "member/common/getVerify"

-- 信息列表获取 未读的
EmailListNotRead_URL = BASE_URL .. "member/adminnotice/batchReadAllMessage"
EmailList_URL = BASE_URL .. "member/adminnotice/findMessagePageResult"
EmailDelete_URL = BASE_URL .. "member/adminnotice/deleteMsgByLogical"

----------洗码功能
-- 获得活动的对应列表
GET_ACTIVITY = BASE_URL.."discount/discountMarketing4MobileController/queryDicountMarketing"
-- 洗码数据
WASHCODE_DATA = BASE_URL.."discount/returnPoint/findReturnPoint"
-- 手洗操作
WASHCODE_MANUAL = BASE_URL.."discount/returnPoint/receiveReturnPoint"
-- 获取查询相关的按钮
WASHCODE_POINT = BASE_URL.."member/platfromBet/findGameItemListByPlatfrom"
--  获取比例
WASHCODE_RETURN_POINT = BASE_URL.."discount/returnPoint/listMemberReturnPoint"
--  获得记录数据
WASHCODE_RECORDING = BASE_URL.."discount/returnPoint/pageMemberReturnPoint"
--end

---客服功能
CUSTOMER_BACK = BASE_URL.."member/webconfig/findByRecWebConfig"

