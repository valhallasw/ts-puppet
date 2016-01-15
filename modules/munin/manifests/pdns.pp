class munin::pdns {
	tspkg {
		munin-plugin-pdns: ;
	}

	munin-plugin {
		[pdns_cache,
		pdns_error,
		pdns_latency,
		pdns_qsize,
		pdns_queries,
		pdns_rec]: require => [Tspkg["munin-plugin-pdns"]];
	}

	file {
                "/etc/opt/ts/munin/plugin-conf.d/pdns":
                        owner => root, group => root, mode => 444,
                        source => "puppet:///munin/pdns",
			notify => Service["munin-node"];
	}
}
