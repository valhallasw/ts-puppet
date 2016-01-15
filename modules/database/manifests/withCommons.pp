class database::withCommons {

	file {
		"/usr/local/munin/plugins/mysql_replag":
			owner => root,
			group => root,
			mode => 755,
			source => "puppet:///database/munin-plugins/mysql_replag";
	}

	munin-plugin {
		mysql_replag_commonswiki: plugin => "mysql_replag", local => "true";
	}
}
