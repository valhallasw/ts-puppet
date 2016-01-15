class debian::apt {
        file {
               "apt.conf": 
                        name => "/etc/apt/apt.conf",
                        owner => root, 
                        group => root,   
                        mode => 644,
                        source => "puppet:///debian/apt-apt.conf";

		"preferences":
                        name => "/etc/apt/preferences",
                        owner => root,
                        group => root,
                        mode => 644,
                        source => "puppet:///debian/apt-preferences";

                "apt-sources":
                        name => "/etc/apt/sources.list",
                        owner => root,
                        group => root,
                        mode => 644,
                        source => "puppet:///debian/apt-sources.list",
			require => [ File["preferences"], File["apt.conf"] ],
                        notify => Exec["apt-get-update"];

                "apt-sources-dir":
                        name => "/etc/apt/sources.list.d/",
			ensure => directory,
                        owner => root,
                        group => root,
                        mode => 755;

		"apt-unfree":
                        name => "/etc/apt/sources.list.d/apt-unfree.list",
                        owner => root,
                        group => root,
                        mode => 644,  
                        source => "puppet:///debian/apt-unfree.list",
                        require => File["apt-sources"],
                        notify => Exec["apt-get-update"];



        }
	exec { "apt-get-update":
		command => "/usr/bin/apt-get update",
		refreshonly => true;
	}
}
