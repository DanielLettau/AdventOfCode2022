$workingdir=pwd
$data = gc .\input.txt
$tempfoldername = (New-TemporaryFile).FullName
rm $tempfoldername
$tempfolder = mkdir $tempfoldername
New-PSDrive -Name AOC7 -PSProvider FileSystem -Root $tempfolder | Out-Null
cd AOC7:
switch -Regex ($data) {
    "^\$ cd" {iex "$($_.substring(2))"}
    "^\d" 
    {
        $filename = $_.split(' ')[1..999]
        [int]$size = $_.split(' ')[0]
        $f = [System.IO.FileStream]::new("$((pwd).Path.Replace('AOC7:',$tempfoldername))\$($filename)", "Create", "ReadWrite")
        $f.SetLength($size)
        $f.Close()
    }
    "^dir" {mkdir $_.substring(4)|Out-Null}
}
dir aoc7:\ -Recurse -Attributes "d" | select fullname,@{N='Size';E={dir $_.fullname -Recurse | measure Length -sum | select -ExpandProperty sum}} | ? {$_.size -le 100000} | measure -sum Size | select -exp Sum
cd $workingdir
Remove-PSDrive aoc7
Remove-Item -Recurse $tempfolder -Confirm:$false