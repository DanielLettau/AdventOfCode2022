$data = gc .\input.txt
$total = 0
foreach ($d in $data) {
    $elf1 = iex ($d.split(',')[0].replace('-','..'))
    $elf2 = iex ($d.split(',')[1].replace('-','..'))
    $equals = @(Compare-Object $elf1 $elf2 -IncludeEqual -ExcludeDifferent).count
    if ($equals -ge 1) {
        $total++
    }
}
$total