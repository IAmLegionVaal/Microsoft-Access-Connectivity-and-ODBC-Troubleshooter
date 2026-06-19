#requires -Version 5.1
<# Created by Dewald Pretorius #>
param([string]$OutputPath)
if(-not $OutputPath){$OutputPath="$([Environment]::GetFolderPath('Desktop'))\Access_ODBC_Reports"};New-Item $OutputPath -ItemType Directory -Force|Out-Null
$drivers=Get-OdbcDriver -ErrorAction SilentlyContinue|Select-Object Name,Platform,Version;$dsns=Get-OdbcDsn -ErrorAction SilentlyContinue|Select-Object Name,DsnType,Platform,DriverName
@('MICROSOFT ACCESS CONNECTIVITY AND ODBC TROUBLESHOOTER','Created by Dewald Pretorius',"Generated: $(Get-Date)",'ODBC drivers:',($drivers|Format-Table -AutoSize|Out-String -Width 220),'ODBC DSNs:',($dsns|Format-Table -AutoSize|Out-String -Width 220),'Guidance: confirm driver bitness, DSN scope, server reachability, credentials, TLS settings, linked-table paths, and query timeouts.')|Set-Content (Join-Path $OutputPath 'Report.txt') -Encoding UTF8