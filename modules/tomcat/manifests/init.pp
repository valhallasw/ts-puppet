class tomcat {
	tspkg {
		tomcat70: ;
	}

	file {
		"catalina.policy":
			owner => webservd, group => webservd, mode => 0600,
			name => "/var/opt/ts/tomcat/7.0/conf/catalina.policy",
			require => Tspkg[tomcat70], notify => Service[tomcat],
			source => "puppet:///tomcat/catalina.policy";

		"catalina.properties":
			owner => webservd, group => webservd, mode => 0600,
			name => "/var/opt/ts/tomcat/7.0/conf/catalina.properties",
			require => Tspkg[tomcat70], notify => Service[tomcat],
			source => "puppet:///tomcat/catalina.properties";

		"context.xml":
			owner => webservd, group => webservd, mode => 0600,
			name => "/var/opt/ts/tomcat/7.0/conf/context.xml",
			require => Tspkg[tomcat70], notify => Service[tomcat],
			source => "puppet:///tomcat/context.xml";

		"logging.properties":
			owner => webservd, group => webservd, mode => 0600,
			name => "/var/opt/ts/tomcat/7.0/conf/logging.properties",
			require => Tspkg[tomcat70], notify => Service[tomcat],
			source => "puppet:///tomcat/logging.properties";

		"server.xml":
			owner => webservd, group => webservd, mode => 0600,
			name => "/var/opt/ts/tomcat/7.0/conf/server.xml",
			require => Tspkg[tomcat70], notify => Service[tomcat],
			source => "puppet:///tomcat/server.xml";

		"tomcat-users.xml":
			owner => webservd, group => webservd, mode => 0600,
			name => "/var/opt/ts/tomcat/7.0/conf/tomcat-users.xml",
			require => Tspkg[tomcat70], notify => Service[tomcat],
			source => "puppet:///tomcat/tomcat-users.xml";

		"web.xml":
			owner => webservd, group => webservd, mode => 0600,
			name => "/var/opt/ts/tomcat/7.0/conf/web.xml",
			require => Tspkg[tomcat70], notify => Service[tomcat],
			source => "puppet:///tomcat/web.xml";

		"/var/opt/ts/tomcat/7.0/conf/Catalina":
			ensure => directory, owner => webservd, group => webservd,
			mode => 0700, require => Tspkg[tomcat70];

		"/var/opt/ts/tomcat/7.0/work":
			ensure => directory, owner => webservd, group => webservd,
			mode => 0700, require => Tspkg[tomcat70];

		"/var/opt/ts/tomcat/7.0/conf/Catalina/localhost":
			ensure => directory, owner => webservd, group => webservd,
			mode => 0700, require => File["/var/opt/ts/tomcat/7.0/conf/Catalina"];
	}

	service {
		"tomcat":
			name => "svc:/network/ts/tomcat-70:default",
			ensure => running, require => [Tspkg[tomcat70],
				File["catalina.policy", "catalina.properties",
					"context.xml", "logging.properties",
					"server.xml", "tomcat-users.xml", "web.xml"]
			];
	}

}
