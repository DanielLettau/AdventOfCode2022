$data = gc .\input.txt
$map = $data | % {,@([int[]][string[]]$_.ToCharArray())}
$visible = 0
$rowlength = $map[0].Count
for ($y=0;$y -lt $data.Count;$y++) {
    for ($x=0;$x -lt $rowlength;$x++) {
        $tree = $map[$y][$x]
        if ($x -eq 0 -or $y -eq 0 -or $x -eq ($rowlength-1) -or $y -eq ($data.Count-1)) {
            $visible++
        } else {
            $left = $map[$y][0..($x-1)] | measure -Maximum | select -exp Maximum
            $right = $map[$y][($x+1)..($rowlength-1)] | measure -Maximum | select -exp Maximum
            $top = ($map | % {$_[$x]})[0..($y-1)] | measure -Maximum | select -exp Maximum
            $buttom = ($map | % {$_[$x]})[($y+1)..($map.Count-1)] | measure -Maximum | select -exp Maximum
            if ($left -lt $tree -or $right -lt $tree -or $top -lt $tree -or $buttom -lt $tree) {
                $visible++
            }
        }
    }
}
$visible