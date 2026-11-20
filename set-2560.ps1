
$tool = "C:\ProgramData\chocolatey\bin\MultiMonitorTool.exe"

& $tool /SetMonitors "Name=MSI3EA5 Width=2560 Height=1440"

Import-Module BurntToast
New-BurntToastNotification -Text "Display resolution", "MSI3EA5: 2560x1440"
