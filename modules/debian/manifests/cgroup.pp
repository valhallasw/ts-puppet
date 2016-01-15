class debian::cgroup {
        file {
               "cgrules.conf": 
                        name => "/etc/cgrules.conf",
                        owner => root, 
                        group => root,   
                        mode => 644,
                        source => "puppet:///debian/cgrules.conf";

		"cgconfig.conf":
                        name => "/etc/cgconfig.conf",
                        owner => root,
                        group => root,
                        mode => 644,
                        source => "puppet:///debian/cgconfig.conf";

                "/cgroups":
                        name => "/cgroups",
                        owner => root,
                        group => root,
                        mode => 755,
			ensure => directory;

        }

	service {
		"cgconfig":
			name => "cgconfig",
			subscribe => File["cgconfig.conf"],
			require => Service[ldap];
	}

       service {
                "cgred ":
                        name => "cgred ",
                        subscribe => File["cgrules.conf"],
                        require => Service[ldap];
        }

	package {
		"cgroup-bin":
			name => "cgroup-bin",
			require => [File["/cgroups"], File ["cgconfig.conf"], File["cgrules.conf"]];
	}

	
}
