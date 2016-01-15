class postfix::user inherits postfix {

	case $operatingsystem {
		
		debian: {

                        # Postfix configuration for users servers (i.e. forwarding based
                        # on LDAP)
                        File["$confdir/main.cf"] {
                                content => template("postfix/main.cf.user.erb.$operatingsystem")
                        }

                       file {
                                "/usr/local/lib":
                                        ensure => directory, 
					owner => root, 
					group => root;

                                "/usr/local/lib/aliasd":
                                        owner => root, 
					group => root, 
					mode => 0755,
                                        require => [File["/etc/aliasd.conf"],File["/usr/local/lib"]],
					source => "puppet:///postfix/aliasd.Debian";

                                "/etc/aliasd.conf":
                                        owner => root, 
					group => root, 
					mode => 0644,
					notify => Service["aliasd_ser"],
					source => "puppet:///modules/secret/postfix/aliasd.conf";

                                "/etc/init.d/aliasd":
					name => "/etc/init.d/aliasd",
					owner => root, 
					group => root, 
					mode => 0744,
					require => File["/usr/local/lib/aliasd"],
					source => "puppet:///postfix/aliasd.init";

				"postfix-nagios":
					name => "/etc/nagios/nrpe.d/postfix.cfg",
					owner => root,
					group => root,
					mode => 0644,
					require => Service["aliasd_ser"],
					notify => Service["nrpe"],
		                        source => "puppet:///postfix/nagios-aliasd.Debian";
			}

			service {
				aliasd_ser:
					name => "aliasd",
					require => [File["/etc/init.d/aliasd"],Package[postfix]],
					hasrestart => false;
			}
		}

		solaris: {

			# Postfix configuration for users servers (i.e. forwarding based
			# on LDAP)
			File["/etc/opt/ts/postfix/main.cf"] {
				content => template("postfix/main.cf.user.erb.$operatingsystem")
			}
		
			# aliasd
			file {
				"/opt/local/lib":
					ensure => directory, owner => root, group => root;
				"/opt/local/lib/aliasd":	
					source => "puppet:///postfix/aliasd.Solaris",
					owner => root, group => root, mode => 0755,
					require => [File["/etc/opt/ts/aliasd.conf"],File["/opt/local/lib"]];
				"/etc/opt/ts/aliasd.conf":
					source => "puppet:///modules/secret/postfix/aliasd.conf",
					owner => root, group => root, mode => 0644;
				"/var/svc/manifest/network/aliasd.xml":
					ensure => present, mode => 0644,
					owner => root, group => root,
					source => "puppet:///postfix/aliasd.xml",
					require => File["/opt/local/lib/aliasd"],
					notify => Exec["update-smf-aliasd"];
			}

		        exec {
		                "update-smf-aliasd":
		                        command => "svccfg import /var/svc/manifest/network/aliasd.xml",
		                        path => "/sbin:/usr/sbin:/usr/bin",
		                        subscribe => File["/var/svc/manifest/network/aliasd.xml"],
		                        require => File["/var/svc/manifest/network/aliasd.xml"],
					refreshonly => true;
		        }

		        service {
		                "svc:/network/aliasd:default":
		                        ensure => running,
		                        require => Exec[update-smf-aliasd];
		        }
		}
	}
}