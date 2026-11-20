$svv = "C:\ProgramData\chocolatey\bin\SoundVolumeView.exe"
$id = "{0.0.0.00000000}.{1f96a18e-76b1-4e2e-9eb4-b2d1feeec717}"

& $svv /SetDefault "$id" all

Import-Module BurntToast
New-BurntToastNotification -Text "Audio output", "Philips TV"
