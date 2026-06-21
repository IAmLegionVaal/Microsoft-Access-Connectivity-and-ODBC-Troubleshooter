#requires -Version 5.1
<# Created by Dewald Pretorius #>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [ValidateSet('Diagnose','RepairOffice')][string]$Action='Diagnose',
    [string]$OutputPath
)
if(-not $OutputPath){$OutputPath="$([Environment]::GetFolderPath('Desktop'))\Access_ODBC_Reports"}
New-Item -Path $OutputPath -ItemType Directory -Force|Out-Null
$drivers=Get-OdbcDriver -ErrorAction SilentlyContinue|Select-Object Name,Platform,Version
$dsns=Get-OdbcDsn -ErrorAction SilentlyContinue|Select-Object Name,DsnType,Platform,DriverName
@('MICROSOFT ACCESS CONNECTIVITY AND ODBC TROUBLESHOOTER','Created by Dewald Pretorius',"Generated: $(Get-Date)","Action: $Action",'ODBC drivers:',($drivers|Format-Table -AutoSize|Out-String -Width 220),'ODBC DSNs:',($dsns|Format-Table -AutoSize|Out-String -Width 220),'Guidance: confirm driver bitness, DSN scope, server reachability, credentials, TLS settings, linked-table paths, and query timeouts.')|Set-Content (Join-Path $OutputPath 'Report.txt') -Encoding UTF8
if($Action -eq 'RepairOffice'){
    $Client=@("$env:ProgramFiles\Common Files\Microsoft Shared\ClickToRun\OfficeC2RClient.exe","${env:ProgramFiles(x86)}\Common Files\Microsoft Shared\ClickToRun\OfficeC2RClient.exe")|Where-Object{Test-Path -LiteralPath $_}|Select-Object -First 1
    if(-not $Client){throw 'Microsoft 365 Apps repair client was not found.'}
    if($PSCmdlet.ShouldProcess('Microsoft 365 Apps','Run Quick Repair')){
        $Process=Start-Process -FilePath $Client -ArgumentList '/repair user displaylevel=true forceappshutdown=true' -Wait -PassThru
        if($Process.ExitCode -ne 0){throw "Office repair exited with code $($Process.ExitCode)."}
    }
}
Write-Host "Completed. Reports: $OutputPath"
