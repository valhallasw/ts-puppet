class debian::syslog {
        file {

		"/etc/syslog-ng/":
			name => "/etc/syslog-ng/",
			ensure => directory,
                        owner => root,
                        group => root,
                        mode => 755;

               	"syslog-ng.conf": 
                        name => "/etc/syslog-ng/syslog-ng.conf",
                        owner => root, 
                        group => root,   
                        mode => 644,
			require => File["/etc/syslog-ng/"],
                        source => "puppet:///debian/syslog-ng.conf";

        }
	
	package {
		syslog-ng: 
			require => File["syslog-ng.conf"];
	}

}
