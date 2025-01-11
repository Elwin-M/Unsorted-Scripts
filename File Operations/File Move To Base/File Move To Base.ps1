# Ask the user for the root directory
$rootDir = Read-Host "Enter the root directory path"

# Check if the directory exists
if (-Not (Test-Path -LiteralPath $rootDir)) {
    Write-Host "The specified directory does not exist." -ForegroundColor Red
    exit
}

# Get all files recursively from the root directory, excluding the root itself
$files = Get-ChildItem -LiteralPath $rootDir -File -Recurse | Where-Object { $_.DirectoryName -ne $rootDir }

foreach ($file in $files) {
    # Calculate the relative path after the root
    $relativePath = $file.FullName.Substring($rootDir.Length).TrimStart("\")
    
    # Split the relative path to get the first folder after root
    $baseFolderName = $relativePath.Split("\")[0]
    
    # Join the base folder name with the root directory
    $baseFolder = Join-Path -Path $rootDir -ChildPath $baseFolderName

    # Add a trailing backslash
    $baseFolder = $baseFolder + "\"

    #Write-Host $baseFolder -ForegroundColor Red

    # Check if the file is already in the base folder
    if ($file.DirectoryName -eq $baseFolder) {
        Write-Host "Skipping $($file.Name), it's already in the base folder." -ForegroundColor Yellow
        continue
    }

    # Define the destination path in the base folder
    $destinationPath = Join-Path -Path $baseFolder -ChildPath $file.Name

    # Ensure unique filenames by appending a numeric suffix if necessary
    $counter = 1
    while (Test-Path -LiteralPath $destinationPath) {
        $baseName = [IO.Path]::GetFileNameWithoutExtension($file.Name)
        $extension = [IO.Path]::GetExtension($file.Name)
        $destinationPath = Join-Path -Path $baseFolder -ChildPath ("$baseName` ($counter`)$extension")
        $counter++
    }

    # Move the file to the base folder
    try {
        Move-Item -LiteralPath $file.FullName -Destination $destinationPath
        Write-Host "Moved: $($file.FullName) to $destinationPath" -ForegroundColor Green
    } catch {
        Write-Host "Failed to move: $($file.FullName). Error: $_" -ForegroundColor Red
    }
}

# Remove any empty directories left behind
$directories = Get-ChildItem -LiteralPath $rootDir -Directory -Recurse | Sort-Object -Property FullName -Descending

foreach ($dir in $directories) {
    if (-Not (Get-ChildItem -LiteralPath $dir.FullName)) {
        try {
            Remove-Item -LiteralPath $dir.FullName 
            Write-Host "Removed empty directory: $($dir.FullName)" -ForegroundColor Yellow
        } catch {
            Write-Host "Failed to remove directory: $($dir.FullName). Error: $_" -ForegroundColor Red
        }
    }
}
