import "*"
class base {

case $operatingsystem {

        debian: {
	        include scripts
	        include ntp
	        include software::misc_std
		include base::screen
	        include base::users
	        include base::files   
	        include base::hostkeys
	        include base::puppet  
		include base::services
	        include munin
	        include postfix

	        include nrpe

	}

	solaris: {
		include scripts
		include ntp
		include base::files
		include base::hostkeys
		include base::puppet
		include munin
		include postfix
		include nrpe
	
		include base::packages
		include base::users
		include base::services
	}
}
}
