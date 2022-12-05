$data = gc .\input.txt
$prio = [char[]](0..255) -like '[A-Z]'
$totalprio = foreach ($d in $data) {
    $compartment1 = $d.Substring(0,$d.Length/2).ToCharArray()
    $compartment2 = $d.Substring($d.Length/2).ToCharArray()
    $item = (Compare-Object -ExcludeDifferent -IncludeEqual $compartment1 $compartment2).inputobject | Select-Object -Unique
    $prio.indexof([string]$item)+1
}
$totalprio | measure -sum | select -exp sum