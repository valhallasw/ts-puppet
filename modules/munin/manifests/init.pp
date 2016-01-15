import "bsdsoftware"

define munin-plugin($plugin = "",$local = "false") {
	$plugindir = $operatingsystem ? {
		debian => $local ? {
			"false"	=> "/usr/share/munin/plugins/",
			"true" 	=> "/usr/local/munin/plugins/"
		},
		freebsd => "/usr/ts/munin/lib/plugins",
		solaris	=> "/opt/ts/munin/lib/plugins"
	}

	$etcdir = $operatingsystem ? {
		debian => "/etc/munin/plugins/",
		freebsd => "/etc/ts/munin/plugins",
		solaris => "/etc/opt/ts/munin/plugins",
	}

	file {
		"$etcdir/$name":
			ensure => $plugin ? {
				""	=> "$plugindir/$name",
				default	=> "$plugindir/$plugin"
			},
			notify => Service[munin-node],
			require => $operatingsystem ? {
				debian => Package[munin-node],
				freebsd => [Yum[munin-node]],
				solaris => [Tspkg[munin-node, munin-common]]
			};
	}
}
		
class munin {
        # Munin monitoring system
	
	case $operatingsystem {
		debian: {

			file {
				"/usr/local/munin/":
					ensure => directory,
					owner => root,
					group => munin,
					mode => 755;

                                "/usr/local/munin/plugins":      
                                        ensure => directory,
                                        owner => root,
                                        group => munin,
                                        mode => 755;

			}

			package {
				munin-node: 
					 require => Group[munin-group];
				munin-plugins-extra: ;
			}

                        service {
                                "munin-node":
                                        name => "munin-node",
					require => Group[munin-group];
                        }

		        group { 
                		munin-group:
					name => "munin",
		                        gid => 1004,
		                        ensure => present,
					require => Service[ldap];
			}
		}

		freebsd: {
			yum {
				munin-node: ;
			}

			service {
				"munin-node":
					name => "munin_node",
					ensure => running,
					enable => true,
					path => "/usr/ts/rc.d",
					hasstatus => true,
					require => [Yum[munin-node]];
			}
		}
		
		solaris: {
			tspkg {
				munin-common: ;
				munin-node: root => true;
				munin-plugin-memstat: ;
			}

			service {
				"munin-node": 
					name => "svc:/system/munin-node:default",
					ensure => running,
					require => [Tspkg["munin-node"]];
			}
		}
	}

	$confdir = $operatingsystem ? {
		debian => "/etc/munin",
		solaris	=> "/etc/opt/ts/munin",
		freebsd	=> "/etc/ts/munin"
	}

	$group = $operatingsystem ? {
		debian => "root",
		solaris => "root",
		freebsd => "wheel"
	}

        # Standard Munin plugins that all nodes should have
        file {
                "$confdir/munin-node.conf":
                        owner => root, group => $group, mode => 444,
                        source => "puppet:///munin/munin-node.conf",
                        notify => Service[munin-node],
			require => $operatingsystem ? {
				debian => [Package[munin-node]],
				freebsd => [Yum[munin-node]],
				solaris => [Tspkg[munin-node, munin-common]]
			};

                "$confdir/plugin-conf.d/df":
                        owner => root, group => $group, mode => 444,
                        source => "puppet:///munin/df",
                        notify => Service[munin-node],
			require => $operatingsystem ? {
				debian => [Package[munin-node]],
				freebsd => [Yum[munin-node]],
				solaris => [Tspkg[munin-node, munin-common]]
			};

                "/var/log/munin":
                        owner => munin, group => munin, mode => 755,
                        ensure => directory;
        }

	munin-plugin {
		[cpu, df, netstat, iostat, ntp_kernel_err, ntp_kernel_pll_freq,
		 ntp_kernel_pll_off, ntp_offset, ntp_states, paging_in, processes,
		 uptime, users, load]: ;
	}

	case $operatingsystem {
		debian: {
                        munin-plugin {
                                memory: ;
                        }
                }
		solaris: {
			munin-plugin {
				memstat: ;
				io_busy_sd: plugin => "io_busy_";
				io_bytes_sd: plugin => "io_bytes_";
				io_ops_sd: plugin => "io_ops_";
			}

			file { 	
				"$confdir/plugin-conf.d/memstat":
					owner => root, group => $group, mode => 444,
					source => "puppet:///munin/memstat",
					notify => Service[munin-node],
					require => [Tspkg[munin-node, munin-common]];
				"$confdir/plugins/memory":
					ensure => absent;
			}

		}
		
		freebsd: {
			munin-plugin {
				memory: ;
			}
		}
	}
}
