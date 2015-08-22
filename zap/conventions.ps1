$conventions = @{}
$conventions.framework = "4.5x64"
$conventions.buildMode = "Release"
$conventions.solutionFile = (Resolve-Path $rootDir\*.sln -ea SilentlyContinue)
$conventions.scriptDir =  $PSScriptRoot
$conventions.configDir = (Join-Path $rootDir "config")
$conventions.outputDir = (Join-Path $rootDir "output")
$conventions.testResultsDir = (Join-Path $conventions.outputDir "testresults")
$conventions.toolsPath = "C:\tools"
$conventions.unitTestFilePathPattern = "*UnitTests.dll"
$conventions.integrationTestFilePathPattern = "*IntegrationTests.dll"

"Conventions being used:"
"rootDir`t`t: $rootDir"
$conventions.keys | % {
    "$_`t: $($conventions.$_)"
}
"-"
