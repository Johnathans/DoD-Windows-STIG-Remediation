<#
.SYNOPSIS
    Prevents autorun commands from executing automatically.

.DESCRIPTION
    This script disables autorun functionality to prevent malicious code execution
    from removable media and network drives, reducing the attack surface.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-CC-000185
    Severity        : CAT I

.MITRE ATT&CK MAPPING
    T1091 - Replication Through Removable Media
    T1547.001 - Boot or Logon Autostart Execution: Registry Run Keys

.NIST 800-53 MAPPING
    CM-7 - Least Functionality
    SI-3 - Malicious Code Protection

.EXAMPLE
    .\WN11-CC-000185.ps1
    Disables autorun commands and displays the configuration.
#>

#Requires -RunAsAdministrator

# Disable autorun commands
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "NoAutorun" -Value 1 -Type DWord

# Verify configuration
Get-ItemProperty -Path $registryPath -Name "NoAutorun"
