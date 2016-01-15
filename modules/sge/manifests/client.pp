# This class handles SGE on the clients.

class sge::client {
        file {
                "/var/sge":
                        name => "/var/sge",
			ensure => directory,
			owner => sgeadmin, 
			group => sgeadmins, 
			mode => 755,
			require => Service[ldap];

		"/sge":
                	name => "/sge",
                        ensure => directory,
                        owner => sgeadmin,
                        group => sgeadmins,
			require => Service[ldap];

		"sge-profile":
			name => "/etc/profile.d/sge.sh",
			owner => root,
			group => root,
			mode => 644,
			source => "puppet:///sge/sge-profile";

		"nagios-check-sge":
			name => "/usr/local/lib/nagios/plugins/check_sge.py",
			owner => root,
			group => nagios,
			mode => 755,
			require => File["nrpe-local-plugins-dir"],
			source => "puppet:///sge/check_sge.py";

		"sge-nagios-config":
			name => "/etc/nagios/nrpe.d/sge.cfg",
                        owner => root,
                        group => root,
                        mode => 644,
                        require => File["nrpe-conf-dir"],
			notify => Service[nrpe],
                        source => "puppet:///sge/nagios-sge.cfg";

	}

	mount {
        	"/sge":
			atboot => yes,
                        device => "ha-nfs.esi:/global/misc/sge",
                        fstype => "nfs",
			options => "proto=udp,vers=3",
                        ensure => mounted,
                        require => File["/sge"];

		#Remove old mount for /sge62.
                "/sge62":
                        atboot => yes,
                        device => "ha-nfs.esi:/global/misc/sge62",
                        fstype => "nfs",
                        options => "proto=udp,vers=3",
                        ensure => absent;

	}

}
