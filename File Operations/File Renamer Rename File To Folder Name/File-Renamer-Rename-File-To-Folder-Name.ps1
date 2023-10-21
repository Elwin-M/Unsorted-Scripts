$targetPath = Read-Host -Prompt "Enter path of files INSIDE to be renamed"
$totalFiles = 0;
$alteredFiles = 0;
$skippedFiles = 0;
$sortOrder = "Extension, Name" #Extension, LastWriteTime, Name, Date
$sortOrderArr = $sortOrder -split ', ' # splitting the string into an array


if ($targetPath) {
    Write-Host "The current directory is: $targetPath";
    Write-Host "Files are sorted by " $sortOrder
    Write-Host "All extensions are included";
    Read-Host -Prompt "Press Enter to run script";
    $List = Get-ChildItem -LiteralPath $targetPath -Recurse -Directory
    ForEach($Folder in $List) {
        Write-Host "-----------------------------------------------------------------------";
        Write-Host "The working directory is:" $Folder.FullName;
        Write-Host "";
        $i =1;
        (Get-ChildItem -File -LiteralPath $Folder.FullName | Sort-Object $sortOrderArr | %{
            $CurrentName = $_;
            $HalfNewName = $_.Directory.Name +'_';
            $FullNewName =  $HalfNewName + $i.ToString('00000') + $_.extension;
            #TEMP CHANGE TO 3 DIGITS
            #$HalfNewName = $_.Directory.Name +' ';
            #$FullNewName =  $HalfNewName + $i.ToString('000') + $_.extension;
            ########################
      
            if ($CurrentName -like $HalfNewName + '*') {   
                Write-Host (($CurrentName.ToString()).PadRight(30)).Substring(0, 30) -BackgroundColor Red -ForegroundColor Black -NoNewline;
                Write-Host " already exists, skipping";
                $i++;
                $skippedFiles++;
                } else {
		
                    $OldName = ($_.ToString()).PadRight(30).Substring(0, 30);
                    $ChangeToName =  ($_.Directory.Name +'_' + $i.ToString('00000') + $_.extension);
                    Rename-Item -LiteralPath $_.FullName -NewName ($FullNewName);
                    Write-Host "Renamed " -NoNewline;
                    Write-Host (($CurrentName.ToString()).PadRight(30)).Substring(0, 30) -BackgroundColor Red -ForegroundColor Black -NoNewline;
                    Write-Host " TO " -NoNewline; 
                    Write-Host (($FullNewName.ToString()).PadRight(30)).Substring(0, 30) -BackgroundColor Green -ForegroundColor Black ;
                    $i++;
                    $alteredFiles++;
                    }
                }
	     )
        $Count = (Get-ChildItem -File $Folder.FullName).Count;
        $totalFiles = $totalFiles + $Count;
        Write-Host "";
        Write-Host ($Count.ToString('00000')) " - Files in current directory";
        Write-Host ($totalFiles.ToString('00000')) " - Files have been counted so far";
        Write-Host ($skippedFiles.ToString('00000')) " - Files have been skipped so far";
        Write-Host ($alteredFiles.ToString('00000')) " - Files have been renamed so far";
        #Write-Host "File count in directory: $Count. $totalFiles files have been counted so far. $skippedFiles files have been skipped so far. $alteredFiles files have been renamed so far";
        Write-Host "-----------------------------------------------------------------------";
        #Comment here to not pause
        #Read-Host -Prompt "Press Enter to keep going"; ####
    }
    Write-Host ($totalFiles.ToString('00000')) " - Files have been counted";
    Write-Host ($skippedFiles.ToString('00000')) " - Files have been skipped";
    Write-Host ($alteredFiles.ToString('00000')) " - Files have been renamed";
    #Write-Host "$totalFiles total files have been counted. $skippedFiles total files have been skipped. $alteredFiles total files have been renamed";
    Write-Host "";
    Read-Host -Prompt "Completed. Press Enter to exit";
} else {
    Read-Host -Prompt "Path is EMPTY or NULL" 
    }