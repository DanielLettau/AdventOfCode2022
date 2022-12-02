$data = gc .\input.txt
$totalpoints = 0

switch ($data) {
    "A X" {$totalpoints+=(3+1)}
    "A Y" {$totalpoints+=(6+2)}
    "A Z" {$totalpoints+=(0+3)}
    "B X" {$totalpoints+=(0+1)}
    "B Y" {$totalpoints+=(3+2)}
    "B Z" {$totalpoints+=(6+3)}
    "C X" {$totalpoints+=(6+1)}
    "C Y" {$totalpoints+=(0+2)}
    "C Z" {$totalpoints+=(3+3)}
}
$totalpoints