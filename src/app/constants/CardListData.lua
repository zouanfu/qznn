-- 卡片数据

CardListData = {}

-- BlackPeach黑桃
-- RedPeach 红桃
-- PlumBlossom 梅花
-- Square 方块
-- CardListData.Type = {
--     BlackPeach = 1,
--     RedPeach = 2,
--     PlumBlossom = 3,
--     Square = 4
-- }
-- CardListData.TypeBlackPeach=1
-- CardListData.TypeRedPeach=2
-- CardListData.Type_PlumBlossom=3
-- CardListData.Type_Square=4

-- type 类型 黑桃1 红桃2 梅花3 黑桃4
-- index位置，卡牌2-A位置为1-13
function CardListData:getCardData(type, index)
    -- statements
    if type == 1 then
        return 'res/card/mpnn_effect_' .. index .. '.png'
    end
    if type == 2 then
        return 'res/card/mpnn_effect_' .. (index + 13) .. '.png'
    end

    if type == 3 then
        return 'res/card/mpnn_effect_' .. (index + 26) .. '.png'
    end

    if type == 4 then
        return 'res/card/mpnn_effect_' .. (index + 39) .. '.png'
    end
end

-- 返回资源文件的路径
-- function CardListData:getBlackPeach(index)
--     -- statements
--     return 'res/card/mpnn_effect_' .. index
-- end

return CardListData
