<#
.SYNOPSIS
    Disables printing over HTTP to prevent information disclosure.

.DESCRIPTION
    This script disables HTTP-based printing to prevent potential information disclosure
    and man-in-the-middle attacks by forcing encrypted printing protocols.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-CC-000110
    Severity        : CAT II

.MITRE ATT&CK MAPPING
    T1040 - Network Sniffing
    T1557 - Adversary-in-the-Middle

.NIST 800-53 MAPPING
    SC-8 - Transmission Confidentiality
    CM-7 - Least Functionality

.EXAMPLE
    .\WN11-CC-000110.ps1
    Disables HTTP printing and displays the configuration.
#>

#Requires -RunAsAdministrator

# Disable HTTP printing
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "DisableHTTPPrinting" -Value 1 -Type DWord

# Verify configuration
Get-ItemProperty -Path $registryPath -Name "DisableHTTPPrinting"
