$basePath = Read-Host -Prompt "Enter base path that contains all the files"
$favsPath = Read-Host -Prompt "Enter favourites path where the hardlinks will be created"

# Recursively search the $basePath for all folders
Get-ChildItem $basePath -Recurse -Directory | ForEach-Object {
    # Get the relative path of the current folder
    $relativePath = $_.FullName.Replace("$basePath\", "")
    # Check if the current folder exists in $favsPath
    $favsFolder = Join-Path $favsPath $relativePath
    if (Test-Path $favsFolder) {
        # If the folder exists in $favsPath, create hardlinks for all the files in the folder
        Get-ChildItem $_.FullName | Where-Object { !$_.PSIsContainer } | ForEach-Object {
            cmd /c fsutil hardlink create "$($favsFolder)\$($_.Name)" $_.FullName
        }
    }
}

#Prompt:
#How can I create a powershell script that uses the new syntax where it recursively searches a path, 
#and it holds the last folder, 
#and then if finds the same folder at a different path (which it searches recursivley provided a base apth), 
#then hardlinks all the files from the different path into the last folder in the first path

#Answer:
#This script uses the Get-ChildItem cmdlet to recursively search for all the folders in $basePath. 
#For each folder, it checks if a folder with the same relative path exists in $favsPath. 
#If the folder exists, it creates hardlinks for all the files in the folder using the fsutil command.