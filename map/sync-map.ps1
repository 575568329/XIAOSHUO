# sync-map.ps1
# 从 regions.json 同步到 index.html

$json = Get-Content "D:\Agent Object\XIAOSHUO\map\regions.json" -Raw -Encoding UTF8 | ConvertFrom-Json

# 生成 CONFIG.regions 代码
$regionsCode = ""
foreach ($region in $json.regions.PSObject.Properties) {
    $name = $region.Value.name
    $race = $region.Value.race
    $status = $region.Value.status
    $danger = $region.Value.danger
    $desc = $region.Value.desc
    
    if ($region.Value.blood) {
        $blood = $region.Value.blood
        $regionsCode += "                '$($region.Name)': { name: '$name', race: '$race', blood: '$blood', status: '$status', danger: '$danger', desc: '$desc' },
"
    } else {
        $regionsCode += "                '$($region.Name)': { name: '$name', race: '$race', status: '$status', danger: '$danger', desc: '$desc' },
"
    }
}

Write-Host "已生成 $($json.regions.PSObject.Properties.Count) 个区域的代码"
Write-Host "请手动复制到 index.html 的 CONFIG.regions 中"
