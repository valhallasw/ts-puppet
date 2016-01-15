class ntp {
	case $operatingsystem {

		debian: {
			$group = "ntp"
			$service = "ntp"
			$svcreqs = [File["ntp.conf"], Package[ntp]]

        		group { "ntp": 
				gid => 211,
		                ensure => present;
			}

        		user { "ntp":  
		                uid => 211,
				gid => 211,
				comment => "NTP user",
		                home => "/var/lib/ntp", 
				shell => "/bin/false",
		                ensure => present, 
				require => Group[ntp];
		        }

			package { "ntp":
				require => [Group[ntp],User[ntp],File["ntp.conf"]],
				ensure => installed;
			}

		        file {
		                "ntp.conf":
		                        name => "/etc/ntp.conf", owner => root, group => $group, mode => 644,
					notify => Service["ntp"],
		                        source => "puppet:///ntp/ntp.conf.debian";
		        }

			service {
				ntp:
					name => ntp,
					require => User["ntp"];
			}

		}

		freebsd: {
			$group = "wheel"
			$service = "ntpd"
			$svcreqs = [File["ntp.conf"]]

                        file {
                                "ntp.conf":
                                        name => "/etc/ntp.conf", owner => root, group => $group, mode => 644,
                                        source => "puppet:///ntp/ntp.conf";
                        } 

		}

		solaris: {
			$group = "root"
			$service = "svc:/network/ts-ntp4:default"

			service {
				"svc:/network/ntp:default": ensure => stopped, enable => false;
				"svc:/network/ntp4:default": ensure => stopped, enable => false;
			}

			tspkg { "ntp": root => true; }
			$svcreqs = [File["ntp.conf"], Tspkg[ntp], Service["svc:/network/ntp:default"]]

                        file {
                                "ntp.conf":
                                        name => "/etc/ntp.conf", owner => root, group => $group, mode => 644,
                                        source => "puppet:///ntp/ntp.conf";
                        } 

		        if ($virtual == "zone") {
		                # zones can't run NTP
		                service {
		                        $service:
		                                ensure => stopped,
		                                enable => false,
		                                require => $svcreqs;
		                }
		        } else { 
		                service {
		                        $service:
		                                ensure => running,
		                                enable => true,
		                                subscribe => File["ntp.conf"],
		                                require => $svcreqs;
		                }
		        }
		}
	}
}
