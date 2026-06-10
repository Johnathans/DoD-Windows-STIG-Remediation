<#
.SYNOPSIS
    Enables audit logging for Credential Validation success events on Windows 11.

.DESCRIPTION
    This script configures the system to audit successful credential validation attempts,
    which is critical for detecting unauthorized access attempts and maintaining compliance
    with DoD STIG requirements.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-AU-000010
    Severity        : CAT II

.MITRE ATT&CK MAPPING
    T1078 - Valid Accounts
    T1110 - Brute Force

.NIST 800-53 MAPPING
    AU-2 - Audit Events
    AU-12 - Audit Generation

.EXAMPLE
    .\WN11-AU-000010.ps1
    Enables credential validation success auditing and displays the current configuration.
#>

#Requires -RunAsAdministrator

# Enable Credential Validation success auditing
auditpol /set /subcategory:"Credential Validation" /success:enable

# Verify configuration
auditpol /get /subcategory:"Credential Validation"
