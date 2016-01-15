class cronie {
	tspkg {
		cronie: ;
	}

	file {
		"/etc/opt/ts/cron.deny":
			content => "";
	}

	service {
		"cronie":
			name => "svc:/system/cronie:default",
			ensure => running,
			require => Tspkg[cronie];
	}

	include cronie::munin
}	
