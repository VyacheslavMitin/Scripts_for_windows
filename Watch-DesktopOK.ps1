
$DesktopOK = "C:\ProgramData\chocolatey\lib\desktopok\tools\DesktopOK_x64.exe"
$Layout = "C:\Users\sonic\Documents\DesktopOK_2560x1440.dok"
$Log = "$env:USERPROFILE\Documents\DesktopOK-watch.log"

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class DisplayInfo {
    [DllImport("user32.dll")]
    public static extern int GetSystemMetrics(int nIndex);
    public static string Resolution() {
        return GetSystemMetrics(0) + "x" + GetSystemMetrics(1);
    }
}
"@

function Write-Log($Message) {
    $Time = Get-Date -Format 'dd.MM.yyyy HH:mm:ss'
    $Line = "[$Time] $Message"
    Write-Host $Line
    $Line | Out-File -Append -Encoding utf8 $Log
}

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "       DesktopOK Auto Restore Monitor" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

if (!(Test-Path $DesktopOK)) {
    Write-Log "ERROR: DesktopOK.exe not found!"
    exit
}

if (!(Test-Path $Layout)) {
    Write-Log "ERROR: DOK layout file not found!"
    exit
}

$Last = [DisplayInfo]::Resolution()

Write-Log "Monitor started successfully."
Write-Log "Current resolution: $Last"
Write-Log "Layout file: $Layout"
Write-Log "Waiting for resolution changes..."
Write-Host ""

while ($true) {
    Start-Sleep -Milliseconds 500
    $Now = [DisplayInfo]::Resolution()

    if ($Now -ne $Last) {
        Write-Host ""
        Write-Log "============================================"
        Write-Log "RESOLUTION CHANGE DETECTED!"
        Write-Log "Previous: $Last"
        Write-Log "Current: $Now"
        Write-Log "Waiting 3 seconds for stabilization..."

        $Candidate = $Now
        $Stable = Get-Date

        while ($true) {
            Start-Sleep -Milliseconds 250
            $Check = [DisplayInfo]::Resolution()

            if ($Check -ne $Candidate) {
                $Candidate = $Check
                $Stable = Get-Date
                Write-Log "Resolution changed again: $Candidate"
            }

            if (((Get-Date) - $Stable).TotalSeconds -ge 3) {
                break
            }
        }

        Write-Log "Restoring DesktopOK layout..."

        try {
            & $DesktopOK /load /silent $Layout

            if ($LASTEXITCODE -eq 0) {
                Write-Log "SUCCESS: Layout restored!"
            } else {
                Write-Log "WARNING: DesktopOK exit code: $LASTEXITCODE"
            }
        }
        catch {
            Write-Log "RESTORE ERROR: $_"
        }

        $Last = $Candidate

        Write-Log "Current resolution: $Last"
        Write-Log "Waiting for next change..."
        Write-Host ""
    }
}
