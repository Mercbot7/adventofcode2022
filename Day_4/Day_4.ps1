$Day4_Input = Get-Content ./input.txt

$Input_Items = @()

foreach ($InputItem in $Day4_Input) {
    $Assignments = $InputItem -split ","
    $elf1 = (Invoke-Expression "$($Assignments[0] -replace "-","..")") -join ","
    $elf2 = (Invoke-Expression "$($Assignments[1] -replace "-","..")") -join ","
    $Contained = $false
    $Overlap = $false

    $range1 = $Assignments[0] -split "-"
    $range2 = $Assignments[1] -split "-"

    # if ( ( ([int]$range1[0] -le [int]$range2[0]) -and ([int]$range1[1] -ge [int]$range2[1]) ) -or ( ([int]$range2[0] -le [int]$range1[0]) -and ([int]$range2[1] -ge [int]$range1[1]) ) ){
    #     $Contained = $true
    # } 

    if ( (([int]$range1[0] -in [int]$range2[0]..[int]$range2[1]) -and ([int]$range1[1] -in [int]$range2[0]..[int]$range2[1])) -or (([int]$range2[0] -in [int]$range1[0]..[int]$range1[1]) -and ([int]$range2[1] -in [int]$range1[0]..[int]$range1[1])) ){
        $Contained = $true
    }

    if ( (([int]$range1[0] -in [int]$range2[0]..[int]$range2[1]) -or ([int]$range1[1] -in [int]$range2[0]..[int]$range2[1])) -or (([int]$range2[0] -in [int]$range1[0]..[int]$range1[1]) -or ([int]$range2[1] -in [int]$range1[0]..[int]$range1[1])) ){
        $Overlap = $true
    }

    $Input_Items += New-Object psobject -Property @{
        "Assignments" = $Assignments;
        # "elf1" = $elf1;
        # "elf2" = $elf2;
        "Contained" = $Contained;
        "Overlap" = $Overlap;
    }
}

($Input_Items | Where-Object {$_.Contained -eq $true}).count

($Input_Items | Where-Object {$_.Overlap -eq $true}).count