<#
.Synopsis
   This script prompts the user to provide a path to a CSV file, verifies the validity and accessibility of the file, and then displays its contents in a grid format.
.DESCRIPTION
    1) Get Input Path of the CSV:
    The user is prompted to enter the file path to a CSV file they wish to view.

    2) Test if the File is a CSV:
    The script checks if the provided file path has a .csv extension to ensure it's in the correct format.

    3) Test Access to CSV:
    It verifies whether the file exists and if the program has permission to read it.

    4) Display the Results in Grid:
    Once validated, the contents of the CSV file are loaded and displayed in a structured grid format for easy viewing.

.EXAMPLE
   Example of how to use this cmdlet
#>

function Validate-CSVFileName {    
    param (
        [Parameter(Mandatory = $true)]
        [string]$CsvPath
    )    
    $regex = '(?:[a-zA-Z]:\\|\\\\[^\\/:*?"<>|\r\n]+\\[^\\/:*?"<>|\r\n]+\\)(?:[^\\/:*?"<>|\r\n]+\\)*[^\\/:*?"<>|\r\n]+\.csv'

    if ($CsvPath -match $regex) {
       return $true
    } else {
        return $false
    }
}

function Exit-Script {
    Read-Host "Enter to exit...."    
    exit    
}

$getCSVFilePath=(Read-Host "Enter CSV File Path").Trim().Trim('"').Trim("'")

if(Validate-CSVFileName -CsvPath $getCSVFilePath)
{
    Write-Host "$getCSVFilePath is valid csv, will continue :)" -ForegroundColor Green
}
else {
    Write-Host "$getCSVFilePath is not a valid csv, will not continue :(" -ForegroundColor Red
    Exit-Script
}


if(!(Test-Path $($getCSVFilePath)))
{
    Write-Host "No access to path $getCSVFilePath" -ForegroundColor Red  
    Exit-Script      
}


Import-Csv $getCSVFilePath | Out-GridView
Exit-Script 
