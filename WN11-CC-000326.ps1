<#
.SYNOPSIS
    Enables PowerShell script block logging for security monitoring.

.DESCRIPTION
    This script enables PowerShell script block logging to capture detailed information
    about PowerShell script execution, aiding in threat detection and incident response.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-CC-000326
    Severity        : CAT II

.MITRE ATT&CK MAPPING
    T1059.001 - Command and Scripting Interpreter: PowerShell
    T1562.002 - Impair Defenses: Disable Windows Event Logging

.NIST 800-53 MAPPING
    AU-2 - Audit Events
    AU-12 - Audit Generation
    SI-4 - System Monitoring

.EXAMPLE
    .\WN11-CC-000326.ps1
    Enables PowerShell script block logging and displays the configuration.
#>

#Requires -RunAsAdministrator

# Enable PowerShell script block logging
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "EnableScriptBlockLogging" -Value 1 -Type DWord

# Verify configuration
Get-ItemProperty -Path $registryPath -Name "EnableScriptBlockLogging"
