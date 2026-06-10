<#
.SYNOPSIS
    Configures the Application event log maximum size to meet DoD STIG requirements.

.DESCRIPTION
    This script sets the Application event log maximum size to 32,768 KB (32 MB) to ensure
    adequate log retention for security monitoring and incident response activities.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-AU-000500
    Severity        : CAT II

.MITRE ATT&CK MAPPING
    T1070.001 - Indicator Removal: Clear Windows Event Logs
    T1562.002 - Impair Defenses: Disable Windows Event Logging

.NIST 800-53 MAPPING
    AU-4 - Audit Storage Capacity
    AU-11 - Audit Record Retention

.EXAMPLE
    .\WN11-AU-000500.ps1
    Sets the Application event log to 32 MB and displays the configuration.
#>

#Requires -RunAsAdministrator

# Set Application event log maximum size to 32 MB
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "MaxSize" -Value 0x00008000 -Type DWord

# Verify configuration
Get-ItemProperty -Path $registryPath -Name "MaxSize"
