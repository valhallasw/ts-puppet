class userserver::mounts inherits esams::mounts {
	Mount["/home"] {
		device => "ha-nfs.esi:/global/home"
	}

        case $operatingsystem {
                debian: {

#SGE's dirs are handled by the sge-class.

		        mount { 

                               "/mnt/user-store": 
                                        atboot => yes,
                                        blockdevice => "-",
                                        device => "rosemary:/mnt/user-store",  
                                        fstype => "nfs",
                                        ensure => mounted,
                                        require => File["/mnt/user-store"] ;
		        }

			file {

                               "/mnt/user-store":
                                        name => "/mnt/user-store",
                                        ensure => directory,
                                        owner => root,
                                        group => users;

			}



		}
	}

}
