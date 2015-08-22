function KillAllNunitAgents {
        Get-Process nunit-agent -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        Get-Process nunit-console -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}

function Run-NunitTests {
     param(
        [Parameter(Position = 0, Mandatory = 1)][string] $testFilePathPattern,
        [Parameter(Position = 1, Mandatory = 1)][string] $outputFilename = "1.0.0",
        [Parameter(Position = 2, Mandatory = 0)][string] $searchDir = "$rootDir\src\",
        [Parameter(Position = 3, Mandatory = 0)][string] $categoryName = "",
        [Parameter(Position = 4, Mandatory = 0)][bool] $showLabels = $false
        )

    $toolsPath, $testResultsDir = Get-Conventions toolsPath, testResultsDir
    Write-Host "searchDir $searchDir"
    $list = gci $searchDir -filter $testFilePathPattern -recurse |
         where {   $_.FullName -notmatch 'obj|Debug' } |
         ForEach-Object -Process {$_}

    $nunit = "$toolsPath\NUnit\nunit-console.exe"

    if ($list.count -eq 0) {
     return
    }

    Write-Host "Test assemblies found: $list"

    if([string]::IsNullOrEmpty($categoryName)) {
        $list | ForEach-Object -Process {
            $testFilePath = $_.FullName
            $resultFile = $_.Name + '-' + $outputFilename
            Write-Host "Running tests for assembly $testFilePath"
            KillAllNunitAgents

            if ($showLabels) {
                & $nunit /labels $testFilePath /xml=$testResultsDir\$resultfile
            }
            else {
                & $nunit $testFilePath /xml=$testResultsDir\$resultfile
            }

            if (!$?) {
                exit 1
            }
        }
    }
    else {
        $list | ForEach-Object -Process {
            $testFilePath = $_.FullName
            $resultFile = $_.Name + '-' + $outputFilename
            Write-Host "Running tests for assembly $testFilePath"
            & $nunit /include:$categoryName $testFilePath /xml=$testResultsDir\$outputFilename
            if (!$?) {
                exit 1
            }

        }
    }
}
