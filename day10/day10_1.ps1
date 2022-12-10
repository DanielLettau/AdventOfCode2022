$data = gc .\input.txt
$cycle = 0
$X = 1
$NextCycle = 20
$result = 0
function IncreaseCycle ($amount = 1) {
    1..$amount | % {
        $script:cycle++
        if ($cycle -eq $NextCycle) {
            $script:result += $cycle * $X
            $script:NextCycle += 40
        }
    }
}
$data | % {
    $instruction, $value = $_.split(' ')
    switch ($instruction) {
        'noop' { IncreaseCycle }
        'addx' {
            IncreaseCycle 2
            $X += $value
        }
    }
}
$result