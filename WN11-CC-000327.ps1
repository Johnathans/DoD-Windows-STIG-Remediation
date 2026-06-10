<#
.SYNOPSIS
    Enables PowerShell transcription for comprehensive session logging.

.DESCRIPTION
    This script enables PowerShell transcription to create detailed logs of all
    PowerShell session activity, supporting security monitoring and forensic analysis.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-CC-000327
    Severity        : CAT II

.MITRE ATT&CK MAPPING
    T1059.001 - Command and Scripting Interpreter: PowerShell
    T1070.001 - Indicator Removal: Clear Windows Event Logs

.NIST 800-53 MAPPING
    AU-2 - Audit Events
    AU-3 - Content of Audit Records
    AU-12 - Audit Generation

.EXAMPLE
    .\WN11-CC-000327.ps1
    Enables PowerShell transcription and displays the configuration.
#>

#Requires -RunAsAdministrator

# Enable PowerShell transcription
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "EnableTranscripting" -Value 1 -Type DWord

# Verify configuration
Get-ItemProperty -Path $registryPath -Name "EnableTranscripting"
