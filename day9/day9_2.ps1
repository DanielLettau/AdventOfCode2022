$data = gc .\input.txt
$knotcount = 10
$knots = 1..$knotcount | % { , @(11, 5) }
$history = New-Object System.Collections.ArrayList
$history.add("$($knots[1][0]) $($knots[1][1])") | Out-Null

foreach ($command in $data) {
    $direction, $steps = $command.Split()
    for ($step = 1; $step -le $steps; $step++) {
        switch ($direction) {
            'R' { $knots[0][0] += 1 }
            'L' { $knots[0][0] -= 1 }
            'U' { $knots[0][1] += 1 }
            'D' { $knots[0][1] -= 1 }
        }
        for ($k = 1; $k -lt $knotcount; $k++) {
            if ([math]::abs($knots[$k - 1][0] - $knots[$k][0]) -gt 1 -or [math]::abs($knots[$k - 1][1] - $knots[$k][1]) -gt 1) {
                switch -Wildcard ("$($knots[$k-1][0] -ne $knots[$k][0]) $($knots[$k-1][1] -ne $knots[$k][1])") {
                    "True*" { $knots[$k][0] = ($knots[$k][0]..$knots[$k - 1][0])[1] }
                    "*True" { $knots[$k][1] = ($knots[$k][1]..$knots[$k - 1][1])[1] }
                }
            }
        }
        $history.add( "$($knots[-1][0]) $($knots[-1][1])") | Out-Null
    }
}

$history | select -Unique | measure | select -ExpandProperty Count