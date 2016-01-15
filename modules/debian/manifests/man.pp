class debian::man {
        file {
               "manpath.config": 
                        name => "/etc/manpath.config",
                        owner => root, 
                        group => root,   
                        mode => 644,
			notify => Exec["man-pages-update"],
                        source => "puppet:///debian/manpath.config";


        }
	exec { "man-pages-update":
		command => "/usr/bin/mandb",
		refreshonly => true;
	}
}
