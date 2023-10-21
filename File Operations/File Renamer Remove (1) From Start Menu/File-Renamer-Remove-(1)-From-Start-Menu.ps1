$folderPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

# Get a list of all shortcuts in the folder
$shortcuts = Get-ChildItem -Path $folderPath -Filter "*.lnk" | Where-Object { $_.Name -match " \(\d+\)\.lnk$" }

# Iterate through the shortcuts and remove them
foreach ($shortcut in $shortcuts) {
    Write-Host "Removing File: $($shortcut.Name)"
    Remove-Item -Path $shortcut.FullName
}
