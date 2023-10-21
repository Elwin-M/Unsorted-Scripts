$folderPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

# Get a list of all shortcuts in the folder
$shortcuts = Get-ChildItem -Path $folderPath -Filter "*.lnk" | Where-Object { $_.Name -match "^(.+)\.lnk$" }

# Iterate through the shortcuts and process them
foreach ($shortcut in $shortcuts) {
    
    # Check if the shortcut name contains " (*)"
    if ($shortcut.Name -match "^(.+)\s\(\d+\)\.lnk$") {

        Write-Host "File Name: $shortcut"
        $shortenedName = $matches[1] + ".lnk"

        # Display the extracted name
        Write-Host "Extracted Name: $shortenedName"

        # Get the path of the shortcut file (excluding the file name)
        $shortcutPath = Split-Path -Path $shortcut.FullName -Parent

        # Remove the original shortcut file
        Write-Host "Removing Original File: $shortcutPath\$shortenedName"
        Remove-Item -Path $shortcutPath\$shortenedName

        # Rename the shortcut
        Write-Host "Renaming File to: $shortenedName"
        Rename-Item -Path $shortcut.FullName -NewName $shortenedName
        Write-Host ""
    }
}