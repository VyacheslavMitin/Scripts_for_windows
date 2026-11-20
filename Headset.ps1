$svv = "C:\ProgramData\chocolatey\bin\SoundVolumeView.exe"
$id = "{0.0.0.00000000}.{8c241ab9-a757-4530-8099-62825a54f735}"

& $svv /SetDefault "$id" all

Import-Module BurntToast
New-BurntToastNotification -Text "Audio output", "Headset"
