class base::services {
	# /etc/services


case $operatingsystem {

debian: {

	file {
		"/etc/services":
			name => "/etc/services",
			mode => 644,
			source => "puppet:///base/services.Debian";
	}
}

solaris: {
	 file {
                "/etc/inet/services":
                        name => "/etc/inet/services",
                        mode => 644,
                        source => "puppet:///base/services.Solaris";
        }
}
}
}
