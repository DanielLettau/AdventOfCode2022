$data = gc .\input.txt
$totalpoints = 0
switch ($data) {
    "A X" {$totalpoints+=(0+3)}
    "A Y" {$totalpoints+=(3+1)}
    "A Z" {$totalpoints+=(6+2)}
    "B X" {$totalpoints+=(0+1)}
    "B Y" {$totalpoints+=(3+2)}
    "B Z" {$totalpoints+=(6+3)}
    "C X" {$totalpoints+=(0+2)}
    "C Y" {$totalpoints+=(3+3)}
    "C Z" {$totalpoints+=(6+1)}
}
$totalpoints