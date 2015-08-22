gci $PSScriptRoot\..\functions -filter "*.ps1" | % { . $_.FullName }
gci $PSScriptRoot\ -filter "*.task.ps1" -r | % { . $_.FullName }
