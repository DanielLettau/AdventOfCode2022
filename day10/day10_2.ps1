$data = gc .\input.txt
$cycle = 0
$X = 1
$NextCycle = 40
function IncreaseCycle ($amount = 1) {
    1..$amount | % {
        $script:cycle++
        if ($cycle % 40 -in ($X..($X + 2))) {
            Write-Host -NoNewline '#'
        }
        else {
            Write-Host -NoNewline '.'
        }
        if ($cycle -eq $NextCycle) {
            Write-Host ''
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