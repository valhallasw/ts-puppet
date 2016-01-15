import "*"

class userserver inherits base {

case $operatingsystem {

	debian: {
		include scripts
		include auditing
		include postfix::user
		include userserver::files
		include userserver::mounts
		include userserver::scripts
		include userserver::locale
		include userserver::operators
		include userserver::motd
		include software::python
	        include software::misc_user
		include software::libmisc_user
	        include software::tcl                           
	        include software::osm   
	        include software::devel    
	        include software::ccandmono
	        include software::perl5
	        include software::java 
		include software::mollyguard
		include software::php
		include software::lua
		include software::vim
		include userserver::scripts
		include sge::client
	}

        solaris: {

		include auditing
		include postfix::user
		include userserver::files
		include userserver::scripts
		include userserver::mounts
		include userserver::motd
		include software::python26_modules
		include software::python27_modules
		include software::python31_modules
		include software::python32_modules
		include software::misc_user
		include software::php53
		include software::gnu
		include software::tcl
		include software::osm
		include software::devel
		include software::apache
	
		service {
			"svc:/system/tcptune:default":
				ensure => running;
		}
	
	       	 file { "/mnt/user-store":
	       	         ensure => directory,
	       	         owner => root,
	       	         group => users,
	       	         mode => 1777
	       	 }

        	mount { "/mnt/user-store":
	                atboot => yes,
       		        blockdevice => "-",
	                device => "rosemary:/mnt/user-store",
	                fstype => "nfs",
	                options => "proto=udp,vers=3",
	                remounts => true,
	                pass => "-",
	                ensure => mounted,
	                require => File["/mnt/user-store"]
	        }
}
}
}
