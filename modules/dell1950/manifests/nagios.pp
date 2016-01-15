class dell1950::nagios {
        file {
                nagios-dell1950:
                        name => "/etc/nagios/nrpe.d/dell-1950.cfg", 
			owner => root, 
			group => nagios, 
			mode => 644,
			notify => Service["nrpe"],
                        source => "puppet:///dell1950/nagios-dell-1950.cfg";
	}
}
