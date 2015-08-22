function ExecAndPrint($command){
    Write-Host 'Executing : '
    Write-Host "$command"
    Exec $command
}
