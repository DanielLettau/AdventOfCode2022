$data = gc .\input.txt
$prio = @{}
65..90  | % {$prio.add([char]$_,$_-38)}
97..122 | % {$prio.add([char]$_,$_-96)}
$totalprio = foreach ($d in $data) {
    $compartment1 = $d.Substring(0,$d.Length/2).ToCharArray()
    $compartment2 = $d.Substring($d.Length/2).ToCharArray()
    $item = (Compare-Object -ExcludeDifferent -IncludeEqual $compartment1 $compartment2).inputobject | Select-Object -Unique
    $prio.$item
}
$totalprio | measure -sum | select -exp sum