
$firstPath = Read-Host -Prompt "Enter path of files to be copied"

# Get the files which should be moved, without folders
$files = Get-ChildItem $firstPath -Recurse | where {!$_.PsIsContainer} ###################################################################EDIT HERE

# List Files which will be moved
$files
 
# Target Filder where files should be moved to. The script will automatically create a folder for the year and month.
#$targetPath = '' ###################################################################EDIT HERE
$secondPath = Read-Host -Prompt "Enter path to where the copies should go"


foreach ($file in $files)
{
# Get year and Month of the file
# I used LastWriteTime since this are synced files and the creation day will be the date when it was synced
$year = $file.LastWriteTime.Year.ToString()
$month = $file.LastWriteTime.Month.ToString('00')
$day = $file.LastWriteTime.Day.ToString('00')
$n = 1

#$year = $file.CreationTime.Year.ToString()
#$month = $file.CreationTime.Month.ToString('00')
#$day = $file.CreationTime.Day.ToString('00')
 

# Out FileName, year and month
$file.Name + ' : ' + $year + ' ' + $month  + ' ' + $day
#$month
#$day

# Set Directory Path
#$Directory = $secondPath + "\" + $year + "\" + $year + ' ' + $month
#$Directory = $secondPath + "\" + $year + ' ' + $month + ' ' + $day
$Directory = $secondPath + "\" + $year + ' ' + $month
#$Directory = $secondPath + "\" + $month + ' ' + $day
# Create directory if it doesn't exist
if (!(Test-Path $Directory))
{
New-Item $directory -type directory
}
 
# Copy/ Move Files to new location
#$file | Copy-Item -Destination $Directory

$file | Move-Item -Destination $Directory

}
# Pause
Read-Host -Prompt "Completed. Press Enter to exit";