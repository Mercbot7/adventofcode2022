$Day1_Input = Get-Content ./input.txt

$iElves = ($Day1_Input | out-string) -split "`n`n"

$elves = @()

$elfcount = 1

foreach ($elf in $iElves) {
    $calory_ints = [int[]]($elf -split "`n")
    $elves += New-Object PSObject -Property @{
        "elf" = $elfcount;
        "elfcaloriesitems" = $calory_ints;
        "totalcallories" = [int]($calory_ints | Measure-Object -Sum).Sum
    }
    $elfcount++
}

$largest = ($elves | Sort-Object -Property totalcallories)[-1]
$largest.totalcallories

$top3 = ($elves | Sort-Object -Property totalcallories)[-1..-3]
$top3total = $top3.totalcallories | Measure-Object -Sum
$top3total.sum