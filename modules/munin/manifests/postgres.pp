class munin::postgres {
	file {
		"/etc/opt/ts/munin/plugin-conf.d/postgres":
			owner => root, group => root, mode => 444,
			source => "puppet:///munin/postgres",
			notify => Service[munin-node];
	}

	munin-plugin {
		postgres_bgwriter: ;
		postgres_connections_db: ;
		postgres_users: ;
		postgres_xlog: ;
	}
}
