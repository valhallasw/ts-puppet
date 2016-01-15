class database::expresstrain {

        file {
                "/etc/munin/plugin-conf.d/expresstrain":
                        owner => root,
                        group => root,
                        mode => 644,
			require => Package["munin-node"],
                        source => "puppet:///database/munin-config-expresstrain.$operatingsystem";
        }


	file {
		"/usr/local/munin/plugins/expresstrain_cache":
			owner => root,
			group => root,
			mode => 755,
			source => "puppet:///database/munin-plugins/expresstrain_cache";
	}

        file {
                "/usr/local/munin/plugins/expresstrain_read-write":
                        owner => root,
                        group => root,
                        mode => 755,
                        source => "puppet:///database/munin-plugins/expresstrain_read-write";
        }

        file {
                "/usr/local/munin/plugins/expresstrain_writerdoings":
                        owner => root,
                        group => root,
                        mode => 755,
                        source => "puppet:///database/munin-plugins/expresstrain_writerdoings";
        }

	munin-plugin {
		expresstrain_cache: plugin => "expresstrain_cache", local => "true";
		expresstrain_read-write: plugin => "expresstrain_read-write", local => "true";
		expresstrain_writerdoings: plugin => "expresstrain_writerdoings", local => "true";
	}
}
