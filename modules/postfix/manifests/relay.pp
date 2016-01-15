class postfix::relay inherits postfix::user {
	# Postfix configuration for relay servers
	File["/etc/opt/ts/postfix/main.cf"] {
		content => template("postfix/main.cf.relay.erb")
	}

	tspkg {
		opendkim: ;
	}

	file {
		"opendkim.conf": 
			name => "/etc/opt/ts/opendkim/opendkim.conf",
			owner => root, group => root, mode => 0644,
			source => "puppet:///postfix/opendkim.conf",
			require => Tspkg[opendkim],
			notify => Service[opendkim];

		"toolserver.org.private":
			name => "/etc/opt/ts/opendkim/toolserver.org.private",
			owner => postfix, group => postfix, mode => 0600,
			source => "puppet:///modules/secret/postfix/toolserver.org.private",
			notify => Service[opendkim],
			require => Tspkg[opendkim];
	}

        service {
                "opendkim":
			name => "svc:/network/ts/opendkim:default",
			require => [Tspkg[opendkim], File["opendkim.conf"], File["toolserver.org.private"]],
                        ensure => running;
        }
}
