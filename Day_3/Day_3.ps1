$Day3_Input = Get-Content ./input.txt

$alpha_ref = @()
$alpha = [char[]]([char]'a'..[char]'z') + [char[]]([char]'A'..[char]'Z')
for ($a = 1; $a -le $alpha.count; $a++) {
    $alpha_ref += New-Object psobject -Property @{
        "char" = $alpha[$a - 1];
        "num" = $a;
    }
}

$Input_Items = @()

Foreach ($InputItem in $Day3_Input) {
    $Item1 = $InputItem[0..($InputItem.length / 2 - 1)]
    $Item2 = $InputItem[($InputItem.length / 2)..($InputItem.length - 1)]
    $CommonChar = (Compare-Object -ReferenceObject $Item1 -DifferenceObject $Item2 -ExcludeDifferent).InputObject | Sort-Object -Unique
    $Input_Items += New-Object psobject -Property @{
        "Item1" = $Item1;
        "Item2" = $Item2;
        "CommonChar" = $CommonChar;
        "CharVal" = ($alpha_ref | Where-Object {$_.char -cmatch $CommonChar}).num;
        "Uniques" = $InputItem[0..($InputItem.length - 1)] | Sort-Object -Unique
    }
}

($Input_Items.CharVal | Measure-Object -Sum).sum

$Item_Groups = @()

$increment = 3

for ($i = 0; $i -lt $Input_Items.count; $i += $increment) {
    $Sack1 = $Input_Items[$i]
    $Sack2 = $Input_Items[$i + 1]
    $Sack3 = $Input_Items[$i + 2]

    $Compare1 = (Compare-Object -ReferenceObject $Sack1.Uniques -DifferenceObject $Sack2.Uniques -ExcludeDifferent).InputObject | Sort-Object -Unique
    $CroupCommonChar = (Compare-Object -ReferenceObject $Compare1 -DifferenceObject $Sack3.Uniques -ExcludeDifferent).InputObject | Sort-Object -Unique
    $GroupCharVal = ($alpha_ref | Where-Object {$_.char -cmatch $CroupCommonChar}).num

    $Item_Groups += New-Object psobject -Property @{
        "GroupCommonChar" = $CroupCommonChar;
        "GroupCharVal" = $GroupCharVal;
    }
}

($Item_Groups.GroupCharVal | Measure-Object -Sum).sum