task RestorePackages {
    $solutionFile, $toolsPath = Get-Conventions solutionFile, toolsPath
    $nuget = $toolsPath + "\nuget\nuget.exe"
    & $nuget restore $solutionFile
}
