# FileCleaner

A PowerShell project for periodic log file cleanup.  
Includes a log generator sub-project for testing purposes.

## How it works
- Reads directories and retention days from `LogDirectories.csv`
- Finds log files matching pattern `Application-Log-YYYY-MM-DD.txt`
- Deletes files older than the retention period
- Includes `LogGenerator.ps1` to create sample logs with date stamps

## Run
```powershell
# Run log generator (inside Logs folder)
.\LogGenerator.ps1

# Run file cleaner
.\filecleaner.ps1
```

## Example CSV Format
```CSV
DirectoryPath,KeepForDays
.\Logs,30

```

## License
MIT