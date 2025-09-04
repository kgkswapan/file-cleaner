
# Resolve script root (works in console and script)
$ScriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

# CSV lives next to this script
$DirectoryListFilePath = [System.IO.Path]::GetFullPath('.\LogDirectories.csv', $ScriptRoot)
$DriectoryList = Import-Csv -Path $DirectoryListFilePath -Delimiter ','

# Reference date (keep your explicit date)
$today = [datetime]"2025-04-11"

foreach ($directory in $DriectoryList) {
    # Allow relative paths inside CSV; resolve against script folder
    $dirPath = [System.IO.Path]::GetFullPath($directory.DirectoryPath, $ScriptRoot)

    Get-ChildItem -Path $dirPath -File -Filter 'Application-Log-*.txt' |
    Where-Object {
        # Only parse names that match the expected pattern
        if ($_.BaseName -match '^Application-Log-(\d{4}-\d{2}-\d{2})$') {
            [datetime]$matches[1] -lt $today.AddDays(-[int]$directory.KeepForDays)
        } else { $false }
    } |
    Remove-Item
    # Tip while testing: append -WhatIf to Remove-Item
}
