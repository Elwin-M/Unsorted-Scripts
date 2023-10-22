# Define the paths to the folders with incorrect and original names
$incorrectFolder = Read-Host -Prompt "Enter path with incorrect names"
$originalFolder = Read-Host -Prompt "Enter path with correct names"

# Get a list of files from both folders
$incorrectFiles = Get-ChildItem -Path $incorrectFolder
$originalFiles = Get-ChildItem -Path $originalFolder

# Check if the number of files in both folders is the same
if ($incorrectFiles.Count -ne $originalFiles.Count) {
    Write-Host "The number of files in the two folders doesn't match. Please make sure they are identical."
    exit
}

# Loop through the files in the incorrect folder and rename them based on the original folder
for ($i = 0; $i -lt $incorrectFiles.Count; $i++) {
    $incorrectFile = $incorrectFiles[$i]
    $originalFile = $originalFiles[$i]
    
    # Get the new name from the original folder
    $newName = $originalFile.Name
    
    # Construct the full path for the new name
    $newPath = Join-Path -Path $incorrectFolder -ChildPath $newName

    # Rename the file
    Rename-Item -Path $incorrectFile.FullName -NewName $newName
    Write-Host "Renamed $($incorrectFile.Name) to $newName"
}
