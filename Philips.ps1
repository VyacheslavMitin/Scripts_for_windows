$svv = "C:\ProgramData\chocolatey\bin\SoundVolumeView.exe"
$id = "{0.0.0.00000000}.{92091404-018d-4b0b-bb50-1ac605ff65c3}"

& $svv /SetDefault "$id" all

Import-Module BurntToast
New-BurntToastNotification -Text "Audio output", "Philips TV"
