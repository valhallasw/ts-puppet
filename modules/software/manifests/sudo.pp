class software::sudo {

case $operatingsystem {

	debian: {
		package {
			sudo: ensure => absent;
			sudo-ldap:;
		}

		file {
                               "/etc/sudoers":
                                        owner => root, 
					group => root, 
					mode => 0440,
                                        source => "puppet:///software/sudo-sudoers-debian";

				sudoers-ldap:
					name => "/etc/sudo-ldap.conf",
                                        owner => root, 
                                        group => root, 
                                        mode => 444,
                                        source => "puppet:///base/ldap.conf";
		}
	}

	solaris: {
                        tspkg {
                                sudo: root => true;
                        }

                        file {
                                "/etc/opt/ts/sudo":
                                        require => File["/etc/opt/ts"],
                                        owner => root, group => sys, mode => 755, ensure => directory;
                
                                "/etc/opt/ts/sudo/ldap.conf":
                                        require => File["/etc/opt/ts/sudo"],
                                        owner => root, group => root, mode => 444,
                                        source => "puppet:///base/ldap.conf";
                        }
		}
	}
}
