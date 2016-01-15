class munin::postfix {
	file {
		postfix_munin:
			name => $operatingsystem ? {
                                debian => "/etc/munin/plugin-conf.d/postfix",
                                solaris => "/etc/opt/ts/munin/plugin-conf.d/postfix"
                        },
			owner => root, group => root, mode => 444,
			source => "puppet:///munin/postfix",
			notify => Service[munin-node],
			require => $operatingsystem ? {
				debian => Package[munin-node],
				solaris => Tspkg[munin-node]
			};
	}

	munin-plugin {
		postfix_mailqueue: ;
		postfix_mailstats: ;
		postfix_mailvolume: ;
	}
}
