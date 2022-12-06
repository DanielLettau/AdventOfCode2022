[char[]]$data=gc .\input.txt
for ($i=0;$i -le $data.Length;$i++) {
    $signal = $data[$i..($i+3)]
    if (($signal | select -Unique).count -eq 4) {
        for ($m=$i+4;$m -le $data.Length;$m++) {
            $message = $data[$m..($m+13)]
            if (($message | select -Unique).count -eq 14) {
                $m+14
                break
            }
        }
        break
    }
}