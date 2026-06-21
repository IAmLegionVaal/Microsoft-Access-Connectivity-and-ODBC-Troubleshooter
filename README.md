# Microsoft Access Connectivity and ODBC Troubleshooter

Created by **Dewald Pretorius**.

`Troubleshooter.ps1` inventories Access ODBC drivers, DSNs, linked-connectivity evidence, and guidance. It now supports a guarded Microsoft 365 Apps Quick Repair mode.

```powershell
.\Troubleshooter.ps1 -Action Diagnose
.\Troubleshooter.ps1 -Action RepairOffice -WhatIf
.\Troubleshooter.ps1 -Action RepairOffice -Confirm
```

The tool records driver and DSN state before repair. It does not modify DSNs, linked tables, credentials, or database content. Microsoft 365 Apps repair may require elevation and closes Office applications. Source-reviewed for Windows PowerShell 5.1; not runtime-tested against every ODBC provider.
