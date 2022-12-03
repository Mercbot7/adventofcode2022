# Rock > Scissors
# Scissors > Paper
# Paper > Scissors

$Day2_Input = Get-Content ./input.txt

$X = New-Object PSObject -Property @{"Play" = "Rock"; "Score" = 1;}
$Y = New-Object PSObject -Property @{"Play" = "Paper"; "Score" = 2;}
$Z = New-Object PSObject -Property @{"Play" = "Scissors"; "Score" = 3;}

$A = New-Object PSObject -Property @{"Play" = "Rock"; "Points" = 1;}
$B = New-Object PSObject -Property @{"Play" = "Paper"; "Points" = 2;}
$C = New-Object PSObject -Property @{"Play" = "Scissors"; "Points" = -3;}

X = Lose
Y = Draw
z = Win

function rps ($play) {
    $out = switch -regex ($play) {
        "[A|X]" {"Rock"; break;}
        "[B|Y]" {"Paper"; break;}
        "[C|Z]" {"Scissors"; break;}
    }
    return $out
}

function rps_result ($play) {
    $out = switch ($play) {
        "X" {"Loss"; break;}
        "Y" {"Draw"; break;}
        "Z" {"Win"; break;}
    }
    return $out
}

$Outcomes = @()

foreach ($round in $Day2_Input) {
    $round_plays = $round -split " "
    $elf_play = rps $round_plays[0]
    $my_play = rps $round_plays[1]


    $round_points = 0
    $myplay_points = switch ($my_play) {
        "Rock" {1; break;}
        "Paper" {2; break;}
        "Scissors" {3; break;}
    }
    $match_points = 0
    $match_result = "Loss"

    if ($elf_play -eq $my_play) {
        $match_result = "Draw"
        $match_points = 3
    }
    elseif ( (($elf_play -eq "Rock") -and ($my_play -eq "Paper")) -or (($elf_play -eq "Paper") -and ($my_play -eq "Scissors")) -or (($elf_play -eq "Scissors") -and ($my_play -eq "Rock")) ) {  
        $match_points = 6
        $match_result = "Win"
    }

    $round_points = $myplay_points + $match_points

    $Outcomes += New-Object psobject -Property @{
        "round_input" = $round;
        "elf_play" = $elf_play;
        "my_play" = $my_play;
        "myplay_points" = $myplay_points;
        "match_result" = $match_result;
        "match_points" = $match_points;
        "round_points" = $round_points;
    }

}

$total_points = $outcomes.round_points | Measure-Object -sum
$total_points.Sum

##### Part 2

$Outcomes = @()

foreach ($round in $Day2_Input) {
    $round_plays = $round -split " "
    $elf_play = rps $round_plays[0]
    $match_result = rps_result $round_plays[1]
    $my_play = ""

    $round_points = 0
    $match_points = 0

    if ($match_result -eq "Draw") {
        $my_play = $elf_play
        $match_points = 3
    }
    elseif ($match_result -eq "Win") {
        $match_points = 6
        $my_play = switch ($elf_play) {
            "Rock" {"Paper"; break;}
            "Paper" {"Scissors"; break;}
            "Scissors" {"Rock"; break;}
        }
    }
    else {
        $my_play = switch ($elf_play) {
            "Rock" {"Scissors"; break;}
            "Paper" {"Rock"; break;}
            "Scissors" {"Paper"; break;}
        }
    }

    $myplay_points = switch ($my_play) {
        "Rock" {1; break;}
        "Paper" {2; break;}
        "Scissors" {3; break;}
    }

    $round_points = $myplay_points + $match_points

    $Outcomes += New-Object psobject -Property @{
        "round_input" = $round;
        "elf_play" = $elf_play;
        "my_play" = $my_play;
        "myplay_points" = $myplay_points;
        "match_result" = $match_result;
        "match_points" = $match_points;
        "round_points" = $round_points;
    }

}

$total_points = $outcomes.round_points | Measure-Object -sum
$total_points.Sum
