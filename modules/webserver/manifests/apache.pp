class webserver::apache {

case $operatingsystem {

       	debian: {

		group {
			webservd:
				name => "webservd",
				gid => 80;
		}

		user {
			webservd:
				name => "webservd",
				require => [File["/www"],Group["webservd"]],
				uid => 80,
				gid => "webservd",
				home => "/www",
				comment => "Webserver-user";
		}

		file {
			apache-localconfig:
				name => "/etc/apache2/conf.d/local",
				owner => root,
				group => root,
				mode => 644,
				require => Package["apache"],
				notify => Service["apache2"],
				source => "puppet:///webserver/apache/config-local";

			apache-envvars:
				name=>"/etc/apache2/envvars",
                                owner => root,
                                group => root,
                                mode => 644,
                                require => [File["/var/log/http"],Package["apache"]],
                                notify => Service["apache2"],
                                source => "puppet:///webserver/apache/envvars";

			"apache-site-toolserver.org":
				name=>"/etc/apache2/sites-available/toolserver.org",
                                owner => root,
                                group => root,
                                mode => 644,
                                require => Package["apache"],
                                notify => Exec["apache-site-toolserver.org"],
                                source => "puppet:///webserver/apache/toolserver.org";

			"/var/log/http":
				name => "/var/log/http/",
				ensure => directory,
                                owner => root,
                                group => root,
                                mode => 755;

			"/var/lib/apache2":
				name => "/var/lib/apache2/",
                                ensure => directory,
				require => User["webservd"],
                                owner => webservd,
                                group => webservd,
                                mode => 755;

                       "/var/lib/apache2/fastcgi":
                                name => "/var/lib/apache2/fastcgi",
                                ensure => directory,
                                require => [File["/var/lib/apache2"],User["webservd"]],
                                owner => webservd,
                                group => webservd,
                                mode => 755;
  
			
		}

		package {
			apache:
				name => apache2-mpm-worker,
				require =>[User["webservd"],Service["ldap"]];

			libapache2-mod-fastcgi: 
				require => [File["/var/lib/apache2/fastcgi"],Package["apache"]];
		}

		service {
			apache2:
				#For the night. --DaB.
				ensure => stopped,
				require => Package["apache"];
		}

		exec {
			"apache-site-toolserver.org":
				command => "/usr/sbin/a2ensite toolserver.org",
				refreshonly => true,
				notify => Service["apache2"];

			"apache-mod-proxy-http":
                                command => "/usr/sbin/a2enmod proxy_http",
                                refreshonly => true,
                                notify => Service["apache2"];

		}

	}

}
}