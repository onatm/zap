function CleanFiles($directory, $pattern){
  Get-ChildItem $directory -include $pattern -Recurse -ErrorAction SilentlyContinue -ErrorVariable errors |
  	foreach ($_) {
  		Write-Host "Deleting " $_.fullname
  		remove-item $_.fullname -Force -Recurse
  	}
  $errors | foreach { write-warning $_.TargetObject; write-warning $_}
}

task Clean  {
    CleanFiles "$rootDir\src" bin,obj
    CleanFiles "$rootDir\output"

    $outputDir = Get-Conventions outputDir

    if(!(Test-Path -Path "$outputDir\TestResults")){
        New-Item "$outputDir\TestResults" -type Directory | Out-Null
    }
}
