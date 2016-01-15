class xen::munin {
	file {
		"/etc/munin/plugin-conf.d/xen":
			owner => root, 
			group => root, 
			mode => 644,
			source => "puppet:///xen/master/munin-config_xen",
			notify => Service["munin-node"],
			require => Package['munin-node'];
	}

	file {
		"/usr/local/munin/plugins/xen_multi":
			owner => root,
			group => munin,
			mode => 755,
			source => "puppet:///xen/master/munin-plugin_xen_multi";
	}

	munin-plugin {
		xen_multi: plugin => "xen_multi", local => "true";
	}
}
