#path to file containing hostnames or ips
#get content from file 
$computers = Get-Content -Path C:\Path\computers.txt

foreach($computer in $computers){
	#check if computer is up
	if (Test-Connection $computer -Count 1 -quiet){
		#remove fiel on remote pc
		rm -path \\$computer\c$\file.msi
		echo $computer " file deleted"
	}
	else {echo $computer " powered off"}
}
