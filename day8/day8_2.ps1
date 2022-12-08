$data = gc .\input.txt
$map = $data | % {,@([int[]][string[]]$_.ToCharArray())}
$rowlength = $map[0].Count
function distance($arr,$height) {
    $dist = 0
    foreach ($tree in $arr) {
        $dist++
        if ($tree -ge $height) {break}
    }
    return $dist
}
$scenicscore = for ($y=0;$y -lt $data.Count;$y++) {
    for ($x=0;$x -lt $rowlength;$x++) {
        if (-not ($x -eq 0 -or $y -eq 0 -or $x -eq ($rowlength-1) -or $y -eq ($data.Count-1))) {
            $tree = $map[$y][$x]
            $ss=@()
            $left = $map[$y][0..($x-1)]
            [array]::reverse($left)
            $right = $map[$y][($x+1)..($rowlength-1)]
            $top = ($map | % {$_[$x]})[0..($y-1)]
            [array]::reverse($top)
            $buttom = ($map | % {$_[$x]})[($y+1)..($map.Count-1)]
            $ss=(distance $left $tree),(distance $right $tree),(distance $top $tree),(distance $buttom $tree)
            iex ($ss -join "*")
        }
    }
}
$scenicscore | measure -Maximum | Select -exp Maximum