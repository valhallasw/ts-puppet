class nrpe {
        case $operatingsystem {
                debian: {
                        package {
				nagios-nrpe-server: 
					require => [User[nagios], File[nrpe-run-dir]],
					notify => Service[nrpe];
                                nagios-plugins: ;
                        }

			file { 
				"nrpe-conf-dir":
	                                name => "/etc/nagios/nrpe.d/",
					ensure => directory,
	                                owner => root,  
	                                group => nagios,
	                                mode => 440,
					require => Package[nagios-nrpe-server];

				"nrpe-run-dir":
                                	name => "/var/run/nagios/",
	                                ensure => directory,
	                                owner => nagios,
	                                group => nagios,
	                                mode => 744;
				
				"nrpe.cfg":
	                                name => "/etc/nagios/nrpe.cfg", 
					owner => root, 
					group => nagios, 
					mode => 440,
	                                require => Package[nagios-nrpe-server], 
					notify => Service[nrpe],
	                                source => "puppet:///nrpe/config/nrpe.cfg";

				"nrpe-local-config":
                                	name => "/etc/nagios/nrpe.d/local.cfg", 
					owner => root, 
					group => nagios, 
					mode => 440,
	                                require => [Package[nagios-nrpe-server],File["nrpe-conf-dir"]], 
					notify => Service[nrpe],
	                                source => "puppet:///nrpe/config/$hostname";

                                "nrpe-default-conf":
                                        name => "/etc/default/nagios-nrpe-server",
                                        owner => root, 
                                        group => root,
                                        mode => 644,
                                        notify => Service[nrpe],
                                        source => "puppet:///nrpe/config/nrpe-default-conf";

                        }


                        service { 
				# Does not prober restart at the moment because of a bug in denian's start-script.
				"nrpe":
					name => "nagios-nrpe-server",
					hasrestart => false,
	                                require => [Package[nagios-nrpe-server], File["nrpe.cfg"]];
                        }

                        group { "nagios":
                                gid => 204,
                                ensure => present;
                        }


			user { "nagios":
                        	ensure => present,
                                comment => "Nagios NRPE",
                                home => "/etc/nagios/",
                                uid => 204, gid => 204,
                                shell => "/bin/false",
                                password => "NP",
                                require => Group["nagios"];
			}

                       file { nrpe-local-dir:
                                name => "/usr/local/lib/nagios/",
                                ensure => directory,
                                owner => root,  
                                group => nagios,
                                mode => 750;
                        }


                       file { nrpe-local-plugins-dir:
                                name => "/usr/local/lib/nagios/plugins/",
                                ensure => directory,
                                owner => root,  
                                group => nagios,
                                mode => 750,
				require => File["nrpe-local-dir"]
                        }


                        file { check-ipmi:
                                name => "/usr/local/lib/nagios/plugins/check-ipmi",
                                owner => root,    
                                group => nagios,
                                mode => 650,
                                require => File["nrpe-local-plugins-dir"],
                                source => "puppet:///nrpe/checks/check_ipmi.Debian";
                        }


                }

		freebsd: {
			yum {
				nrpe: notify => Service[nrpe];
				nagios-plugins: ;
				nagios-check-arc: ;
			}

			file { "nrpe.cfg":
				name => "/etc/ts/nrpe/nrpe.cfg", owner => root, group => wheel, mode => 444,
				require => Yum[nrpe], notify => Service[nrpe],
				source => "puppet:///nrpe/config/$hostname";
			}

			service { "nrpe":
				ensure => running, enable => true, path => "/usr/ts/rc.d", hasstatus => true,
				require => [Yum[nrpe], File["nrpe.cfg"]];
			}
		}

		solaris: {
			tspkg {
				nrpe: root => true, notify => Service["svc:/network/nagios/nrpe:default"];
				nagios-plugins: ;
				nagios-check-smf: ;
				nagios-check-sge-execd: ;
				nagios-check-arc: ;
				nagios-check-ipmi: ;
				nagios-check-disksuite: ;
				nagios-check-scstat: ;
				nagios-check-mem: ;
			}

			file { "nrpe.cfg":
				name => "/etc/opt/ts/nrpe/nrpe.cfg", owner => root, group => root, mode => 444,
				notify => Service["svc:/network/nagios/nrpe:default"],
				require => Tspkg[nrpe],
				source => "puppet:///nrpe/config/$hostname";
			}

			service { "svc:/network/nagios/nrpe:default":
				ensure => running,
				require => [File["nrpe.cfg"], Tspkg[nrpe]];
			}
		}
	}
}
