$data = gc .\input.txt
$prio = @{}
65..90  | % {$prio.add([char]$_,$_-38)}
97..122 | % {$prio.add([char]$_,$_-96)}
$totalprio = for ($i=0;$i -lt $data.Count;$i+=3) {
    $r1=$data[$i].ToCharArray() | select -Unique
    $r2=$data[$i+1].ToCharArray() | select -Unique
    $r3=$data[$i+2].ToCharArray() | select -Unique
    $item = ($r1+$r2+$r3) | Group-Object | ? {$_.count -eq 3} | select -ExpandProperty name
    $prio.[char]$item
}
$totalprio | measure -sum | select -exp sum