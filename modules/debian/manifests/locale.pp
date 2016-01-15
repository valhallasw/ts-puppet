class debian::locale {
        file {

               "locale.gen": 
                        name => "/etc/locale.gen",
                        owner => root, 
                        group => root,   
                        mode => 644,
                        source => "puppet:///debian/locale.gen";

        }
	
	package {
		locales: ;
	}

	exec {
		gen-locales:
			command => "/usr/bin/nice -n 10 /usr/sbin/locale-gen",
			subscribe => File["locale.gen"],
			timeout => 0,
			refreshonly => true;
	}
}
