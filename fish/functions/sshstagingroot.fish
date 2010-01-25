function sshstagingroot
	ssh -i ~/.ec2/citymintadmin.pem root@staging $argv; 
end

