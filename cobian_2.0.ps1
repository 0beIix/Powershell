$computers = Get-Content -Path "C:\Users\username\Documents\installs\computer.txt"
$log = "c$\Program Files (x86)\Cobian Backup 11\Logs\log 2022-06-0*.txt"
$up = "C:\Users\username\Documents\installs\cobian_up.txt"
$down = "C:\Users\username\Documents\installs\cobian_down.txt"
$date = Get-Date -format dd/MM/yy

foreach($computer in $computers){
	if (Test-Connection $computer -Count 1 -quiet){
		if (test-path \\$computer\$log){
			if((Select-String -Path \\$computer\$log -Pattern 'Backup done' -quiet) -and (-not(Select-String -Path $up -Pattern $computer -quiet))) {
				$computer | Out-File -FilePath $up -append }

			elseif(( -not (Select-String -Path \\$computer\$log -Pattern 'Backup done' -quiet)) -and ( -not (Select-String -Path $down -Pattern $computer -quiet))){
				$computer + " - no backup" | Out-File -FilePath $down -append}
		}
		elseif( -not (Select-String -Path $down -Pattern $computer -quiet)) {$computer + " - Cobian not installed" + " - 08/06/22" | Out-File -FilePath $down -append}
	}
	else {$computer + " - powered off" | Out-File -FilePath $down -append}
}

