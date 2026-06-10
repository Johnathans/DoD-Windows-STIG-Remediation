<#
.SYNOPSIS
    Disables indexing of encrypted files to protect sensitive data.

.DESCRIPTION
    This script prevents Windows Search from indexing encrypted files, ensuring that
    encrypted data remains protected and is not exposed through search indexes.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-CC-000305
    Severity        : CAT II

.MITRE ATT&CK MAPPING
    T1005 - Data from Local System
    T1552.004 - Unsecured Credentials: Private Keys

.NIST 800-53 MAPPING
    SC-28 - Protection of Information at Rest
    MP-7 - Media Use

.EXAMPLE
    .\WN11-CC-000305.ps1
    Disables indexing of encrypted files and displays the configuration.
#>

#Requires -RunAsAdministrator

# Disable indexing of encrypted files
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "AllowIndexingEncryptedStoresOrItems" -Value 0 -Type DWord

# Verify configuration
Get-ItemProperty -Path $registryPath -Name "AllowIndexingEncryptedStoresOrItems"
