$Uri =  "https://api.github.com/repos/Zarckash/ZKTool/git/trees/main"
$WebRequest = (Invoke-WebRequest -Uri $Uri -Method GET -UseBasicParsing).Content | ConvertFrom-Json
$LatestSha = $WebRequest.sha
$ShaJson = Get-Content ($Hash.ZKToolPath + "Sha.json") -Raw | ConvertFrom-Json

if ($ShaJson.GlobalSha -ne $LatestSha) {
    Update-GUI Status Text "Comprobando actualizaciones..."

    Test-FunctionsSha
    Test-ResourcesSha

    $ShaJson.GlobalSha = $LatestSha

    $ShaJson | ConvertTo-Json | Set-Content ($Hash.ZKToolPath + "Sha.json") -Encoding UTF8
}

function Test-FunctionsSha {
    for ($i = 0; $i -lt $WebRequest.tree.length; $i++) {
        if ($WebRequest.tree[$i].path -eq "Functions") {
            $FunctionsLatestSha = $WebRequest.tree[$i].sha
        }
    }

    if ($ShaJson.Functions.Sha -ne $FunctionsLatestSha) {
        Update-GUI Status Text "Actualizando funciones..."

        $FunctionsUri =  "https://api.github.com/repos/Zarckash/ZKTool/git/trees/$FunctionsLatestSha"
        $FunctionsWebRequest = (Invoke-WebRequest -Uri $FunctionsUri -Method GET -UseBasicParsing).Content | ConvertFrom-Json

        $FunctionsWebRequest.tree.path | ForEach-Object {
            $Hash.Download.DownloadFile(($Hash.GitHubPath + "Functions/" + $_), ($Hash.ZKToolPath + "Functions/" + $_))
        }
        
        $ShaJson.Functions.Sha = $FunctionsLatestSha
    }
}

function Test-ResourcesSha {
    for ($i = 0; $i -lt $WebRequest.tree.length; $i++) {
        if ($WebRequest.tree[$i].path -eq "Resources") {
            $ResourcesLatestSha = $WebRequest.tree[$i].sha
        }
    }

    if ($ShaJson.Resources.Sha -ne $ResourcesLatestSha) {
        Update-GUI Status Text "Actualizando listas..."

        $ShaJson.Resources.Sha = $ResourcesLatestSha

        $ResourcesUri =  ("https://api.github.com/repos/Zarckash/ZKTool/git/trees/" + $ShaJson.Resources.Sha)
        $ResourcesWebRequest = (Invoke-WebRequest -Uri $ResourcesUri -Method GET -UseBasicParsing).Content | ConvertFrom-Json
    
        $ResourcesWebRequest.tree.path | ForEach-Object {
            if ($_ -eq "*.json") {
                $Hash.Download.DownloadFile(($Hash.GitHubPath + "Resources/" + $_), ($Hash.ZKToolPath + "Resources/" + $_))
            }
        }
        
        Test-ImagesSha
    }
}

function Test-ImagesSha {
    $ImagesUri =  ("https://api.github.com/repos/Zarckash/ZKTool/git/trees/" + $ShaJson.Resources.Sha)
    $ImagesWebRequest = (Invoke-WebRequest -Uri $ImagesUri -Method GET -UseBasicParsing).Content | ConvertFrom-Json

    for ($i = 0; $i -lt $ImagesWebRequest.tree.length; $i++) {
        if ($ImagesWebRequest.tree[$i].path -eq "Images") {
            $ImagesLatestSha = $ImagesWebRequest.tree[$i].sha
        }
    }
    
    if ($ShaJson.Resources.Images.Sha -ne $ImagesLatestSha) {
        Update-GUI Status Text "Actualizando imagenes..."

        $ImagesUri =  ("https://api.github.com/repos/Zarckash/ZKTool/git/trees/" + $ImagesLatestSha)
        $ImagesWebRequest = (Invoke-WebRequest -Uri $ImagesUri -Method GET -UseBasicParsing).Content | ConvertFrom-Json

        $ImagesWebRequest.tree.path | ForEach-Object {
            $Hash.Download.DownloadFile(($Hash.GitHubPath + "Resources/Images" + $_), ($Hash.ZKToolPath + "Resources/Images" + $_))
        }

        $ShaJson.Resources.Images.Sha = $ImagesLatestSha 
    }
}