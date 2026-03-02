# sync-to-html.ps1
# 从 regions.json 同步到 index.html

Write-Host "开始同步..."

# 读取 regions.json
$json = Get-Content "D:\Agent Object\XIAOSHUO\map\regions.json" -Raw -Encoding UTF8 | ConvertFrom-Json

# 生成 regions 代码
$regionsCode = ""
foreach ($region in $json.regions.PSObject.Properties) {
    $id = $region.Name
    $name = $region.Value.name
    $race = $region.Value.race
    $status = $region.Value.status
    $danger = $region.Value.danger
    $desc = $region.Value.desc
    
    if ($region.Value.blood) {
        $blood = $region.Value.blood
        $regionsCode += "                '$id': { name: '$name', race: '$race', blood: '$blood', status: '$status', danger: '$danger', desc: '$desc' },
"
    } else {
        $regionsCode += "                '$id': { name: '$name', race: '$race', status: '$status', danger: '$danger', desc: '$desc' },
"
    }
}

Write-Host "已生成 $($json.regions.PSObject.Properties.Count) 个区域的代码"

# 读取 index.html
$html = Get-Content "D:\Agent Object\XIAOSHUO\map\index.html" -Raw -Encoding UTF8

# 查找并替换 regions 部分
$pattern = "regions: \{[^}]+\}"
$replacement = "regions: {
" + $regionsCode + "            }"

$newHtml = $html -replace $pattern, $replacement

# 保存
$newHtml | Out-File -FilePath "D:\Agent Object\XIAOSHUO\map\index.html" -Encoding UTF8

Write-Host "同步完成！"
Write-Host "请刷新浏览器（Ctrl + F5）查看变化"
