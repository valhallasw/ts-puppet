class munin::zws {
	tspkg {
		munin-plugin-zws: ;
	}

	munin-plugin {
		[zws_cgi,
		zws_conns,
		zws_reqs,
		zws_resp,
		zws_traffic]: require => [Tspkg["munin-plugin-zws"]];
	}

	file {
                "/etc/opt/ts/munin/plugin-conf.d/zws":
                        owner => root, group => root, mode => 444,
                        source => "puppet:///munin/zws",
			notify => Service["munin-node"];
	}
}
