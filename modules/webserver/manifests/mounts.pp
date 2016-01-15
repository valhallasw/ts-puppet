class webserver::mounts {

case $operatingsystem {

       	debian: {

		file {
			"/www": 
				ensure => directory,
				owner => root, 
				group => root, 
				mode => 755;
		}

                mount { 
			"/www":
	                        atboot => yes,
	                        device => "ha-nfs.esi:/global/misc/tsorg-www",
	                        fstype => "nfs",
	                        options => "proto=udp,vers=3",
	                        remounts => true,
	                        pass => "0",
	                        ensure => mounted,
	                        require => File["/www"];
                }

	}

	solaris: {

                file {
                        "/www":
                                ensure => directory,
                                owner => root,
                                group => root,
                                mode => 755;
                }

	        mount { 
			"/www":
	        	        atboot => yes,
		                blockdevice => "-",
		                device => "ha-nfs.esi:/global/misc/tsorg-www",
		                fstype => "nfs",
		                options => "proto=udp,vers=3",
		                remounts => true,
		                pass => "-",
		                ensure => mounted,
		                require => File["/www"];
	        }

	}
}
}