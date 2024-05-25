$Uri =  "https://api.github.com/repos/Zarckash/ZKTool/git/trees/main"
$WebRequest = (Invoke-WebRequest -Uri $Uri -Method GET -UseBasicParsing).Content | ConvertFrom-Json
$LatestSha = $WebRequest.sha
$CurrentSha = Get-Content -Path ($App.ZKToolPath + "sha")

if ($CurrentSha -ne $LatestSha) {
    $Lists = @('Apps.json','Configs.json','Extra.json','Presets.json','Tweaks.json')
    $Lists | ForEach-Object {
        $App.Download.DownloadFile(($App.GitHubPath + "Resources/" + $_),($App.ResourcesPath + $_))
    }
    $LatestSha | Set-Content -Path ($App.ZKToolPath + "sha")
    "sha updated to $LatestSha"
}

for ($i = 0; $i -lt $WebRequest.tree.length; $i++) {
    if ($WebRequest.tree[$i].path -eq "Resources") {
        $ResourcesUrl = $WebRequest.tree[$i].url
    }
}

$Uri = $ResourcesUrl
$WebRequest = (Invoke-WebRequest -Uri $Uri -Method GET -UseBasicParsing).Content | ConvertFrom-Json

for ($i = 0; $i -lt $WebRequest.tree.length; $i++) {
    if ($WebRequest.tree[$i].path -eq "Images") {
        $ImagesUrl = $WebRequest.tree[$i].url
    }
}

$Uri = $ImagesUrl
$WebRequest = (Invoke-WebRequest -Uri $Uri -Method GET -UseBasicParsing).Content | ConvertFrom-Json

$LatestImagesSha = $WebRequest.sha

if (!(Test-Path ($App.ZKToolPath + "Imagessha"))) {
    New-Item ($App.ZKToolPath + "Imagessha") | Out-Null
}

$CurrentImagesSha = Get-Content -Path ($App.ZKToolPath + "Imagessha")

if ($CurrentImagesSha -ne $LatestImagesSha) {
    $Images = $WebRequest.tree.path
    $Images | ForEach-Object {
        $App.Download.DownloadFile(($App.GitHubPath + "Resources/Images" + $_),($App.ResourcesPath + "Images" + $_))
    }
    $LatestImagesSha | Set-Content -Path ($App.ZKToolPath + "Imagessha")
    attrib +h ($App.ZKToolPath + "Imagessha")
    "imagessha updated to $LatestImagesSha" | Out-File $App.LogPath -Encoding UTF8 -Append
}
