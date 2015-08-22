Set-StrictMode -Version Latest

Import-Module "$PSScriptRoot\..\lib\psake\psake.psm1" -Force

function Invoke-Tasks {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = 0)][string[]] $tasks = @('Help'),
        [Parameter(Position = 1, Mandatory = 0)][string] $buildVersion = "1.0.0",
        [Parameter(Position = 2, Mandatory = 0)][string] $buildMinorVersion = "0",
        [Parameter(Position = 3, Mandatory = 0)][string] $rootDir = $pwd,
        [Parameter(Position = 4, Mandatory = 0)][string] $environment,
        [Parameter(Position = 5, Mandatory = 0)][string] $configBuildId = 0,
        [Parameter(Position = 6, Mandatory = 0)][string[]] $applications = @(),
        [Parameter(Position = 7, Mandatory = 0)][string] $categoryName = "NunitFixtureClassName"
    )

    $buildFile = "$PSScriptRoot\tasks\alltasks.ps1"
    . "$PSScriptRoot\conventions.ps1"

    $parameters = @{
        "conventions" = $conventions;
        "buildVersion" = $buildVersion;
        "buildMinorVersion" = $buildMinorVersion;
        "rootDir" = $rootDir;
        "environmentToDeliver" = $environment;
        "configBuildId" = $configBuildId;
        "applicationsToDeliver" = $applications;
        "categoryName" = $categoryName;
    }

    Invoke-Psake $buildFile -taskList  $tasks -parameters $parameters
    exit !($psake.build_success)
}

Export-ModuleMember -function Invoke-Tasks
