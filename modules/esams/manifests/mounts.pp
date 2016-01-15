class esams::mounts {
	# Mount points that all nodes need
	Mount {
		remounts => true,
		options => "proto=udp,vers=3",
		pass => $operatingsystem ? { 
			debian => "0",
			solaris => "-"
		}
	}

	file { "/home":
		ensure => directory,
		mode => 755;
	}

	mount { "/home":
		atboot => yes,
		blockdevice => "-",
		device => "ha-nfs.esi:/global/misc/shome",
		fstype => "nfs",
		ensure => mounted,
		require => File["/home"]
	}

	file { "/shared":
		ensure => directory,
		mode => 750
	}

	mount { "/shared":
		atboot => yes,
		blockdevice => "-",
		device => "ha-nfs.esi:/global/misc/shared",
		fstype => "nfs",
		ensure => mounted,
		require => File["/shared"];
	}

	file { "/install":
		ensure => directory,
		mode => 755;
	}

	mount {

                "/install":
	                name => "/install",
	                atboot => yes,
	                blockdevice => "-",
	                device => "hemlock:/aux1/install",
	                fstype => "nfs",  
	                ensure => mounted,
	                require => [File["/install"]];
	}
}
