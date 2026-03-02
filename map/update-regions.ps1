# update-all-regions.ps1
# 批量更新所有区域信息

$json = Get-Content "D:\Agent Object\XIAOSHUO\map\regions.json" -Raw -Encoding UTF8 | ConvertFrom-Json

# 定义所有区域的详细信息映射
$regionInfo = @{
    # 人类王国
    "北京市" = @{
        cities = "龙石城（王都）"
        towns = "龙石港（天津）、王领卫城（廊坊）"
        resources = "铁矿、粮食、黄金"
        monsters = "无（城市）"
        flight = "限制（需许可）"
        terrain = "平原都市"
        climate = "温带大陆性"
        desc = "人类王国首都，龙石王座所在地。城市：龙石城（王都）、龙石港、王领卫城。资源：铁矿、粮食、黄金。魔兽：无。禁飞：限制。环境：平原都市。"
    }
    "天津市" = @{
        cities = "龙石港"
        towns = "塘沽、汉沽"
        resources = "鱼类、盐、木材"
        monsters = "无（港口）"
        flight = "允许"
        terrain = "海港城市"
        climate = "温带季风"
        desc = "王都门户，繁忙的贸易港口。城市：龙石港、塘沽、汉沽。资源：鱼类、盐、木材。魔兽：无。禁飞：允许。环境：海港城市。"
    }
    "河北省" = @{
        cities = "王领城（石家庄）"
        towns = "保定、邯郸、邢台"
        resources = "粮食、马匹、棉花"
        monsters = "野狼、野猪"
        flight = "允许"
        terrain = "肥沃平原"
        climate = "温带大陆性"
        desc = "王都直辖领地。城市：王领城、保定、邯郸、邢台。资源：粮食、马匹、棉花。魔兽：野狼、野猪。禁飞：允许。环境：肥沃平原。"
    }
    "山东省" = @{
        cities = "金麦城（济南）"
        towns = "青岛港、烟台、潍坊"
        resources = "黄金麦、铁矿、盐"
        monsters = "野猪、狼群"
        flight = "允许"
        terrain = "平原农田"
        climate = "温带季风"
        desc = "王国粮仓。城市：金麦城、青岛港、烟台、潍坊。资源：黄金麦、铁矿、盐。魔兽：野猪、狼群。禁飞：允许。环境：平原农田。"
    }
    "辽宁省" = @{
        cities = "凛冬城（沈阳）"
        towns = "大连港、鞍山、抚顺"
        resources = "铁矿、毛皮、木材"
        monsters = "雪狼、霜熊"
        flight = "限制"
        terrain = "山地要塞"
        climate = "寒温带"
        desc = "北境守护。城市：凛冬城、大连港、鞍山、抚顺。资源：铁矿、毛皮、木材。魔兽：雪狼、霜熊。禁飞：限制。环境：山地要塞。"
    }
    "上海市" = @{
        cities = "翡翠港"
        towns = "浦东、浦西、松江"
        resources = "丝绸、茶叶、瓷器"
        monsters = "无（港口）"
        flight = "允许"
        terrain = "河口港城"
        climate = "亚热带季风"
        desc = "东方最大贸易港。城市：翡翠港、浦东、浦西、松江。资源：丝绸、茶叶、瓷器。魔兽：无。禁飞：允许。环境：河口港城。"
    }
    "江苏省" = @{
        cities = "翡翠城（南京）"
        towns = "苏州、无锡、常州、扬州"
        resources = "稻米、丝绸、鱼"
        monsters = "水蛇、野鸭"
        flight = "允许"
        terrain = "水乡平原"
        climate = "亚热带季风"
        desc = "王国粮仓。城市：翡翠城、苏州、无锡、常州、扬州。资源：稻米、丝绸、鱼。魔兽：水蛇、野鸭。禁飞：允许。环境：水乡平原。"
    }
    "浙江省" = @{
        cities = "银叶城（杭州）"
        towns = "宁波港、温州、绍兴、嘉兴"
        resources = "茶叶、丝绸、竹"
        monsters = "山猫、野兔"
        flight = "允许"
        terrain = "丘陵平原"
        climate = "亚热带季风"
        desc = "丝绸之府。城市：银叶城、宁波港、温州、绍兴、嘉兴。资源：茶叶、丝绸、竹。魔兽：山猫、野兔。禁飞：允许。环境：丘陵平原。"
    }
    "安徽省" = @{
        cities = "银雾城（合肥）"
        towns = "芜湖、蚌埠、安庆"
        resources = "银矿、粮食、丝绸"
        monsters = "无（城市）"
        flight = "限制（迷雾）"
        terrain = "平原都市"
        climate = "亚热带季风"
        desc = "银雾笼罩的神秘城市。城市：银雾城、芜湖、蚌埠、安庆。资源：银矿、粮食、丝绸。魔兽：无。禁飞：限制。环境：平原都市。"
    }
    "重庆市" = @{
        cities = "铁壁城"
        towns = "万州、涪陵、永川"
        resources = "铁矿、铜、石材"
        monsters = "山狼、岩蜥"
        flight = "限制"
        terrain = "山地要塞"
        climate = "亚热带季风"
        desc = "西南要塞。城市：铁壁城、万州、涪陵、永川。资源：铁矿、铜、石材。魔兽：山狼、岩蜥。禁飞：限制。环境：山地要塞。"
    }
}

# 应用更新
foreach ($regionId in $regionInfo.Keys) {
    if ($json.regions.$regionId) {
        $info = $regionInfo[$regionId]
        $json.regions.$regionId | Add-Member -NotePropertyName "cities" -NotePropertyValue $info.cities -Force
        $json.regions.$regionId | Add-Member -NotePropertyName "towns" -NotePropertyValue $info.towns -Force
        $json.regions.$regionId | Add-Member -NotePropertyName "resources" -NotePropertyValue $info.resources -Force
        $json.regions.$regionId | Add-Member -NotePropertyName "monsters" -NotePropertyValue $info.monsters -Force
        $json.regions.$regionId | Add-Member -NotePropertyName "flight" -NotePropertyValue $info.flight -Force
        $json.regions.$regionId | Add-Member -NotePropertyName "terrain" -NotePropertyValue $info.terrain -Force
        $json.regions.$regionId | Add-Member -NotePropertyName "climate" -NotePropertyValue $info.climate -Force
        $json.regions.$regionId.desc = $info.desc
        Write-Host "已更新：$regionId"
    }
}

# 保存
$json | ConvertTo-Json -Depth 10 | Out-File -FilePath "D:\Agent Object\XIAOSHUO\map\regions.json" -Encoding UTF8
Write-Host "`n保存完成！"
