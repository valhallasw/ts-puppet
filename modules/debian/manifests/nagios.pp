class debian::nagios {
        file {
                nagios-debian:
                        name => "/etc/nagios/nrpe.d/debian.cfg",
			owner => root, 
			group => nagios, 
			mode => 644,
			notify => Service["nrpe"],
                        source => "puppet:///debian/nagios-debian.cfg";
	}
}
