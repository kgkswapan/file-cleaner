
# Resolve script root (works in console and script)
$ScriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

# Logs folder is under the project folder
$LogsFolder = [System.IO.Path]::GetFullPath('.\Logs', $ScriptRoot)
if (-not (Test-Path $LogsFolder)) {
    New-Item -Path $LogsFolder -ItemType Directory | Out-Null
}

# Start date and simple loop (keep your approach)
$StartDate = Get-Date "2025-01-01"

for ($i = 0; $i -lt 100; $i++) {
    $date = $StartDate.AddDays($i).ToString("yyyy-MM-dd")
    $filename = "Application-Log-$date.txt"
    $fullPath = Join-Path $LogsFolder $filename
    New-Item -Path $fullPath -ItemType File -Force | Out-Null
}
