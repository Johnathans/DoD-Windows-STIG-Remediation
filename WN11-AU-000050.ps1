<#
.SYNOPSIS
    Enables audit logging for Process Creation success events on Windows 11.

.DESCRIPTION
    This script configures the system to audit successful process creation events,
    enabling detection of malicious process execution and maintaining compliance
    with DoD STIG requirements.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0
    STIG-ID         : WN11-AU-000050
    Severity        : CAT II

.MITRE ATT&CK MAPPING
    T1059 - Command and Scripting Interpreter
    T1204 - User Execution

.NIST 800-53 MAPPING
    AU-2 - Audit Events
    AU-12 - Audit Generation
    SI-4 - System Monitoring

.EXAMPLE
    .\WN11-AU-000050.ps1
    Enables process creation success auditing and displays the current configuration.
#>

#Requires -RunAsAdministrator

# Enable Process Creation success auditing
auditpol /set /subcategory:"Process Creation" /success:enable

# Verify configuration
auditpol /get /subcategory:"Process Creation"
