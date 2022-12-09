$data = gc .\input.txt
class Point {
    [int]$Hx
    [int]$Hy
    [int]$Tx
    [int]$Ty
    [object[]]$historyH
    [object[]]$historyT

    Point ([int]$x, [int]$y) {
        $this.Hx = $x
        $this.Hy = $y
        $this.Tx = $x
        $this.Ty = $y
        $this.historyH += , @($x, $y)
        $this.historyT += "$x $y"
    }

    move($direction, $step) {
        for ($i = 1; $i -le $step; $i++) {
            switch ($direction) {
                'R' { $this.Hx += 1 }
                'L' { $this.Hx -= 1 }
                'U' { $this.Hy += 1 }
                'D' { $this.Hy -= 1 }
            }
            $this.historyH += , @($this.Hx, $this.Hy)
            $diffX = [Math]::Abs($this.Hx - $this.Tx)
            $diffY = [Math]::Abs($this.Hy - $this.Ty)
            if ($diffX -gt 1 -or $diffY -gt 1) {
                $this.Tx = $this.historyH[-2][0]
                $this.Ty = $this.historyH[-2][1]
                $this.historyT += $this.historyH[-2] -join ' '
            }
        }
    }
}
$H = [Point]::new(0, 0)
$data | % {
    $params = $_.split(' ')
    $H.move($params[0], $params[1])
}
$H.historyT | select -Unique | measure | select -exp count