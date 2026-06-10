<#
.SYNOPSIS
    Master script to execute all Windows 11 STIG remediation scripts.

.DESCRIPTION
    This script runs all 10 DISA STIG remediation scripts in sequence, providing
    a comprehensive security hardening solution for Windows 11 systems. Each script
    is executed with error handling and results are logged.

.NOTES
    Author          : Johnathan Smith
    GitHub          : https://github.com/Johnathans
    Date Created    : 2026-06-10
    Last Modified   : 2026-06-10
    Version         : 1.0

.EXAMPLE
    .\Run-AllSTIGs.ps1
    Executes all STIG remediation scripts and generates a summary report.

.EXAMPLE
    .\Run-AllSTIGs.ps1 -Verbose
    Executes all scripts with detailed output.
#>

#Requires -RunAsAdministrator

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [switch]$CreateRestorePoint
)

$ErrorActionPreference = "Continue"
$scriptPath = $PSScriptRoot

$banner = @"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║     Windows 11 DISA STIG Remediation Suite                   ║
║     Author: Johnathan Smith                                  ║
║     GitHub: @Johnathans                                      ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
"@

Write-Host $banner -ForegroundColor Cyan
Write-Host ""

$stigScripts = @(
    @{ID="WN11-AU-000010"; File="WN11-AU-000010.ps1"; Description="Credential Validation Auditing"},
    @{ID="WN11-AU-000050"; File="WN11-AU-000050.ps1"; Description="Process Creation Auditing"},
    @{ID="WN11-AU-000500"; File="WN11-AU-000500.ps1"; Description="Application Event Log Size"},
    @{ID="WN11-CC-000090"; File="WN11-CC-000090.ps1"; Description="Group Policy Reprocessing"},
    @{ID="WN11-CC-000110"; File="WN11-CC-000110.ps1"; Description="Disable HTTP Printing"},
    @{ID="WN11-CC-000185"; File="WN11-CC-000185.ps1"; Description="Prevent Autorun Commands"},
    @{ID="WN11-CC-000305"; File="WN11-CC-000305.ps1"; Description="Disable Encrypted File Indexing"},
    @{ID="WN11-CC-000315"; File="WN11-CC-000315.ps1"; Description="Disable AlwaysInstallElevated"},
    @{ID="WN11-CC-000326"; File="WN11-CC-000326.ps1"; Description="PowerShell Script Block Logging"},
    @{ID="WN11-CC-000327"; File="WN11-CC-000327.ps1"; Description="PowerShell Transcription"}
)

if ($CreateRestorePoint) {
    Write-Host "[*] Creating system restore point..." -ForegroundColor Yellow
    try {
        Checkpoint-Computer -Description "Before STIG Remediation" -RestorePointType "MODIFY_SETTINGS"
        Write-Host "[+] System restore point created successfully" -ForegroundColor Green
    } catch {
        Write-Host "[-] Warning: Could not create restore point: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    Write-Host ""
}

$results = @()
$successCount = 0
$failCount = 0

Write-Host "[*] Starting STIG remediation process..." -ForegroundColor Cyan
Write-Host "[*] Total scripts to execute: $($stigScripts.Count)" -ForegroundColor Cyan
Write-Host ""

foreach ($script in $stigScripts) {
    $scriptFile = Join-Path $scriptPath $script.File
    
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "[*] Executing: $($script.ID) - $($script.Description)" -ForegroundColor Yellow
    Write-Host ""
    
    if (Test-Path $scriptFile) {
        try {
            & $scriptFile
            $results += [PSCustomObject]@{
                STIG_ID = $script.ID
                Description = $script.Description
                Status = "SUCCESS"
                Error = ""
            }
            $successCount++
            Write-Host ""
        } catch {
            $results += [PSCustomObject]@{
                STIG_ID = $script.ID
                Description = $script.Description
                Status = "FAILED"
                Error = $_.Exception.Message
            }
            $failCount++
            Write-Host "[-] Error executing $($script.ID): $($_.Exception.Message)" -ForegroundColor Red
            Write-Host ""
        }
    } else {
        $results += [PSCustomObject]@{
            STIG_ID = $script.ID
            Description = $script.Description
            Status = "NOT FOUND"
            Error = "Script file not found"
        }
        $failCount++
        Write-Host "[-] Script not found: $scriptFile" -ForegroundColor Red
        Write-Host ""
    }
}

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    EXECUTION SUMMARY                          ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total Scripts:    $($stigScripts.Count)" -ForegroundColor White
Write-Host "Successful:       $successCount" -ForegroundColor Green
Write-Host "Failed:           $failCount" -ForegroundColor $(if ($failCount -gt 0) { "Red" } else { "Green" })
Write-Host ""

Write-Host "Detailed Results:" -ForegroundColor Cyan
Write-Host ""
$results | Format-Table -AutoSize

$timestamp = Get-Date -Format "yyyy-MM-dd_HHmmss"
$reportPath = Join-Path $scriptPath "STIG_Remediation_Report_$timestamp.csv"
$results | Export-Csv -Path $reportPath -NoTypeInformation

Write-Host "[+] Report saved to: $reportPath" -ForegroundColor Green
Write-Host ""

if ($failCount -eq 0) {
    Write-Host "[+] All STIG remediations completed successfully!" -ForegroundColor Green
} else {
    Write-Host "[!] Some remediations failed. Please review the errors above." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Review the generated report" -ForegroundColor White
Write-Host "  2. Verify settings with: gpresult /h gpreport.html" -ForegroundColor White
Write-Host "  3. Check audit policy with: auditpol /get /category:*" -ForegroundColor White
Write-Host "  4. Run SCAP compliance checker for full validation" -ForegroundColor White
Write-Host ""
