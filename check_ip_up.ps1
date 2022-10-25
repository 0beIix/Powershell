#path to file containing hostnames or ips
#get content from file 
$computers = Get-Content -Path "C:\Path\computer.txt" 
#path to file to log status
#these two files will be created if not existing 
$up = "C:\Path\on.txt" 
$down = "C:\Path\off.txt"

#cycle through all items in computer.txt
foreach($computer in $computers){
	if (Test-Connection $computer -Count 1 -quiet){
			#write computername to file 
			$computer | Out-File -FilePath $up -append
			#show wich user is logged on -> append to file
			query user /SERVER:$computer | Out-File -FilePath $up -append
	}
	#write computername to fiel, marked as powered off
	else {$computer + " - powered off" | Out-File -FilePath $down -append}
}

