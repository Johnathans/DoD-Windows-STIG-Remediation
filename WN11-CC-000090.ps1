<#
.SYNOPSIS
    Ensures Group Policy objects are reprocessed even if they have not changed.

.DESCRIPTION
    This script configures the system to reprocess Group Policy objects regardless of
    whether they have changed, ensuring security settings are consistently applied
    and preventing policy bypass techniques.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-CC-000090
    Severity        : CAT II

.MITRE ATT&CK MAPPING
    T1484 - Domain Policy Modification
    T1562.001 - Impair Defenses: Disable or Modify Tools

.NIST 800-53 MAPPING
    CM-6 - Configuration Settings
    CM-7 - Least Functionality

.EXAMPLE
    .\WN11-CC-000090.ps1
    Configures Group Policy reprocessing and displays the configuration.
#>

#Requires -RunAsAdministrator

# Enable Group Policy reprocessing even if unchanged
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "NoGPOListChanges" -Value 0 -Type DWord

# Verify configuration
Get-ItemProperty -Path $registryPath -Name "NoGPOListChanges"
