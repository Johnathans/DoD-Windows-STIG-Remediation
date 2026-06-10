<#
.SYNOPSIS
    Disables "Always install with elevated privileges" for Windows Installer.

.DESCRIPTION
    This script prevents Windows Installer from always running with elevated privileges,
    mitigating privilege escalation attacks through malicious MSI packages.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-CC-000315
    Severity        : CAT I

.MITRE ATT&CK MAPPING
    T1548.002 - Abuse Elevation Control Mechanism: Bypass User Account Control
    T1218.007 - System Binary Proxy Execution: Msiexec

.NIST 800-53 MAPPING
    AC-6 - Least Privilege
    CM-7 - Least Functionality

.EXAMPLE
    .\WN11-CC-000315.ps1
    Disables AlwaysInstallElevated and displays the configuration.
#>

#Requires -RunAsAdministrator

# Disable AlwaysInstallElevated
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "AlwaysInstallElevated" -Value 0 -Type DWord

# Verify configuration
Get-ItemProperty -Path $registryPath -Name "AlwaysInstallElevated"
