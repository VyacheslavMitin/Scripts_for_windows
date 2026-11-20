$svv = "C:\ProgramData\chocolatey\bin\SoundVolumeView.exe"
$id = "{0.0.0.00000000}.{4a10e23e-778c-457b-b112-24dc68bf3885}"

& $svv /SetDefault "$id" all

Import-Module BurntToast
New-BurntToastNotification -Text "Audio output", "Headset"
