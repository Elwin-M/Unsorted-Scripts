$folderPath = ""

# Get a list of all folders in the specified directory
$folders = Get-ChildItem -Path $folderPath -Directory

# Iterate through the folders and rename them
foreach ($folder in $folders) {
    # Check if the folder name ends with brackets and remove them
    if ($folder.Name -match "^(.+)\s\([^)]+\)$") {
        $newFolderName = $matches[1].Trim()  # Remove trailing spaces
        Write-Host "Renaming folder: $($folder.Name) to $newFolderName"
        Rename-Item -Path $folder.FullName -NewName $newFolderName -Force
    }
}
