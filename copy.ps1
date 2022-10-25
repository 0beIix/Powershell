#path to file containing hostnames or ips
#get content from file 
$computers = Get-Content -Path "C:\Path\computer.txt"
$cp = "C:\Path\file_copied.txt"
$down = "C:\Path\off.txt"

foreach ($computer in $computers){
	#check if computer is up
	if (Test-Connection $computer -Count 1 -quiet){
		#copy from local pc   to   remote pc
		copy "C:\local\path.ps1" \\$computer\c$
		#log proggress
		$computer | Out-File -FilePath $cp -append
		echo $computer "copied"
	}
	else {$computer + " - powered off" | Out-File -FilePath $down -append}
}
