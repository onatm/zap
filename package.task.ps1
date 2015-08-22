$nuget = "C:\tools\nuget\nuget.exe"

task Pack {

    $dir = $rootDir
    $destDir = "$rootDir\tmp"
    $nugetPackage = "zap.nuspec"

    if(Test-Path $destDir){
        remove-item $destDir -Force -Recurse
    }

    mkdir "$destDir\tools"

    Copy-Item "$rootDir\zap\" -destination "$destDir\tools" -container -recurse
    Copy-Item "$rootDir\lib\" -destination "$destDir\tools" -container -recurse

    & $nuget pack $nugetPackage -version $version -BasePath $destDir
}

task Push {

    if($apiKey.count -gt 0){
        & $nuget setapikey $apiKey -Source $nugetServer
    }

    $packageFileName = "zap.$version.nupkg"
    & $nuget push $packageFileName -s $nugetServer
}
