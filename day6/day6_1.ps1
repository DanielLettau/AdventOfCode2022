[char[]]$data=gc .\input.txt
for ($i=0;$i -le $data.Length;$i++) {
    $signal = $data[$i..($i+3)]
    if (($signal | select -Unique).count -eq 4) {
        $i+4
        break
    }
}