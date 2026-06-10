# DoD Windows 11 STIG Remediation Scripts

**Author:** Johnathan Smith  
**GitHub:** [@Johnathans](https://github.com/Johnathans)  
**Purpose:** PowerShell-based remediation scripts for Windows 11 DISA STIG compliance

---

## Overview

This repository contains 10 PowerShell remediation scripts designed to address specific Windows 11 Security Technical Implementation Guide (STIG) findings. Each script implements security controls mapped to MITRE ATT&CK techniques and NIST 800-53 controls, ensuring comprehensive defense-in-depth protection.

## STIG Controls Implemented

| STIG ID | Category | Severity | Description |
|---------|----------|----------|-------------|
| WN11-AU-000010 | Audit Policy | CAT II | Enable Credential Validation success auditing |
| WN11-AU-000050 | Audit Policy | CAT II | Enable Process Creation success auditing |
| WN11-AU-000500 | Audit Policy | CAT II | Set Application event log to 32 MB minimum |
| WN11-CC-000090 | Configuration | CAT II | Force Group Policy reprocessing |
| WN11-CC-000110 | Configuration | CAT II | Disable HTTP printing |
| WN11-CC-000185 | Configuration | CAT I | Prevent autorun commands |
| WN11-CC-000305 | Configuration | CAT II | Disable indexing of encrypted files |
| WN11-CC-000315 | Configuration | CAT I | Disable AlwaysInstallElevated |
| WN11-CC-000326 | Configuration | CAT II | Enable PowerShell script block logging |
| WN11-CC-000327 | Configuration | CAT II | Enable PowerShell transcription |

## Security Framework Mappings

### MITRE ATT&CK Coverage
- **T1078** - Valid Accounts
- **T1110** - Brute Force
- **T1059** - Command and Scripting Interpreter
- **T1091** - Replication Through Removable Media
- **T1484** - Domain Policy Modification
- **T1548.002** - Bypass User Account Control
- **T1562** - Impair Defenses
- And more...

### NIST 800-53 Controls
- **AU-2, AU-3, AU-4, AU-11, AU-12** - Audit and Accountability
- **CM-6, CM-7** - Configuration Management
- **AC-6** - Access Control
- **SC-8, SC-28** - System and Communications Protection
- **SI-3, SI-4** - System and Information Integrity

## Prerequisites

- Windows 11 (Enterprise or Pro)
- PowerShell 5.1 or higher
- Administrator privileges
- Execution policy allowing script execution

## Usage

### Individual Script Execution

Run each script individually with administrator privileges:

```powershell
# Open PowerShell as Administrator
.\WN11-AU-000010.ps1
```

### Batch Execution

Use the master script to apply all remediations:

```powershell
# Run all STIG remediations
.\Run-AllSTIGs.ps1
```

### Verification

Each script includes built-in verification that displays the current configuration after applying changes.

## Script Features

✅ **Error Handling** - Comprehensive try-catch blocks  
✅ **Admin Validation** - Requires administrator privileges  
✅ **Verification** - Displays configuration after changes  
✅ **Color-Coded Output** - Easy-to-read status messages  
✅ **Security Mappings** - MITRE ATT&CK and NIST 800-53 references  
✅ **Professional Documentation** - Detailed headers and examples  

## Testing Recommendations

1. **Test in a lab environment first**
2. **Create system restore point before applying**
3. **Review each script before execution**
4. **Verify changes with organizational policies**
5. **Document all changes for compliance audits**

## Compliance Verification

After running the scripts, verify compliance using:

- **DISA STIG Viewer** - Review findings against STIG checklist
- **SCC (SCAP Compliance Checker)** - Automated compliance scanning
- **Group Policy Results** - `gpresult /h report.html`
- **Audit Policy** - `auditpol /get /category:*`

## Repository Structure

```
.
├── README.md                    # This file
├── Run-AllSTIGs.ps1            # Master execution script
├── WN11-AU-000010.ps1          # Credential Validation auditing
├── WN11-AU-000050.ps1          # Process Creation auditing
├── WN11-AU-000500.ps1          # Application event log size
├── WN11-CC-000090.ps1          # Group Policy reprocessing
├── WN11-CC-000110.ps1          # Disable HTTP printing
├── WN11-CC-000185.ps1          # Prevent autorun commands
├── WN11-CC-000305.ps1          # Disable encrypted file indexing
├── WN11-CC-000315.ps1          # Disable AlwaysInstallElevated
├── WN11-CC-000326.ps1          # PowerShell script block logging
└── WN11-CC-000327.ps1          # PowerShell transcription
```

## Important Notes

⚠️ **Warning:** These scripts modify system security settings. Always test in a non-production environment first.

⚠️ **Backup:** Create a system restore point before applying changes.

⚠️ **Compliance:** Verify that these settings align with your organization's security policies.

## References

- [DISA STIGs](https://public.cyber.mil/stigs/)
- [Windows 11 STIG](https://www.stigviewer.com/stig/windows_11/)
- [MITRE ATT&CK Framework](https://attack.mitre.org/)
- [NIST 800-53 Controls](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)

## License

This project is provided as-is for educational and compliance purposes.

## Contact

**Johnathan Smith**  
GitHub: [@Johnathans](https://github.com/Johnathans)

---

*Last Updated: June 10, 2026*
