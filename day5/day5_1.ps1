$data = gc .\input.txt
$stacks = for ($i=0;$i -lt $data.count;$i++) {if ($data[$i] -eq '') {$startmovinginstructions=$i+1;$i=$data.count} else {$data[$i]}}
$movinginstructions = $data[$startmovinginstructions..($data.Count-1)]
$stackvarsneeded = ($stacks[-1] -replace '\s{1,}',',').trim(',').split(',').count
1..$stackvarsneeded | % {Remove-Variable "Stack$_" -ErrorAction Ignore;New-Variable -Name "Stack$_" -Value ([System.Collections.ArrayList]::new())}
foreach ($line in $stacks[0..($stacks.count-2)]) {
    $newline = $line -replace '[\s]{4}',',' -replace '[\[]',',' -replace '[\s\]]',''
    $arr = $newline.split(',')
    for ($i=1;$i -le $stackvarsneeded;$i++) {
        if ($arr[$i] -ne '') {
            (Get-Variable "Stack$i").Value.add($arr[$i]) | Out-Null
        }
    }
}

foreach ($m in $movinginstructions) {
    $marr = $m.split(' ')
    $amount =$marr[1]
    $from = $marr[3]
    $to = $marr[5]
    0..($amount-1) | % {
        (Get-Variable "Stack$to").Value.Insert(0,(Get-Variable "Stack$from").Value[$_])
    }
    (Get-Variable "Stack$from").Value.RemoveRange(0,$amount)
}

1..$stackvarsneeded | % {write-host -NoNewline (Get-Variable "Stack$_").value[0]}