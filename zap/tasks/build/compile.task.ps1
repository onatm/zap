function global:Version-AssemblyInfoFiles($version) {

    $newVersion = 'AssemblyVersion("' + $version + '")';
    $newFileVersion = 'AssemblyFileVersion("' + $version + '")';

    Get-ChildItem $rootDir\src -Recurse | ? {$_.Name -eq "AssemblyInfo.cs"} | % {
        $tmpFile = "$($_.FullName).tmp"

        gc $_.FullName |
            %{$_ -replace 'AssemblyVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $newVersion } |
            %{$_ -replace 'AssemblyFileVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $newFileVersion }  | 
              Out-File $tmpFile -encoding UTF8

        Move-Item $tmpFile $_.FullName -force
    }
}

task Compile -depends RestorePackages {
    $buildMode, $solutionFile = Get-Conventions buildMode, solutionFile

    Version-AssemblyInfoFiles $buildVersion

    ExecAndPrint { msbuild $solutionFile /p:Configuration=$buildMode /p:VisualStudioVersion=12.0 /verbosity:minimal /nologo } 
}
