# Specify the directory path
$directoryPath = Read-Host -Prompt "Enter base path to remove hardlinks from"
# Get all files in the directory
$files = Get-ChildItem -Recurse -Path $directoryPath -File

$regularCount = 0
$hardlinkCount = 0

foreach ($file in $files) {
    # Get the file type
    $linkType = (Get-Item $file.FullName).LinkType -eq "HardLink"

    #Check if the file is a hardlink
    if ($linkType) {
        # Write-Host "File: $($file.FullName) is a Hard Link)"
        # Remove the file
        Remove-Item $file.FullName -Force
        Write-Host "Removed hard link: $($file.FullName) `n"
        $hardlinkCount++
    } else {
        Write-Host "File: $($file.FullName) is not Hard Link) `n"
        $regularCount++
    }
}

Write-Host "Hard links removal complete."
Write-Host "Hardlink Count: $hardlinkCount"
Write-Host "Regular Count: $regularCount"