param(
    $tasks = @('Clean', 'Compile', 'RunUnitTests', 'RunIntegrationTests'),
    $buildMajorVersion = "1.0.0",
    $buildMinorVersion = "0",
    $environment = "local",
    $configBuildId = 0,
    $applications = @()
)

echo "Running zap!"

Import-Module $PSScriptRoot\zapper.psm1 -Force
Invoke-Tasks $tasks -buildVersion "$buildMajorVersion.$buildMinorVersion" -buildMinorVersion "$buildMinorVersion" -environment $environment -applications $applications -configBuildId $configBuildId
