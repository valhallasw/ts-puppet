class userserver::files inherits base::files {

case $operatingsystem {

	debian: {
		file {
			"profile-solaris_backcomp":
				name => "/etc/profile.d/solaris_backcomp.sh",
				owner => root,
				group => root,
				mode => 755,
				source => "puppet:///userserver/solaris_backcomp.sh";

			"profile-go_home.sh":
				name => "/etc/profile.d/go_home.sh",
                                owner => root,
                                group => root,
                                mode => 755,
                                source => "puppet:///userserver/profile-go_home.sh";

                        "profile-environment":
                                name => "/etc/profile.d/environment.sh",
                                owner => root,
                                group => root,
                                mode => 755,
                                source => "puppet:///userserver/profile-environment.sh";

                        "/usr/local/bin/sgeperl":
                                ensure => link,
                                owner => root,
                                group => root, 
                                target => "/usr/bin/perl";
		}
	}

	solaris: {
		File <| name == "/etc/pam.conf" |> {
			source => "puppet:///base/pam.conf.login"
		}

		file {
			"/etc/opt/ts/munin/plugins/sge_queue_all.q":
				source => "puppet:///userserver/sge_queue_",
				owner => "root", group => "root",
				mode => 555, ensure => present,
				notify => Service[munin-node];

			"/etc/opt/ts/munin/plugins/sge_host_all.q":
				source => "puppet:///userserver/sge_host_",
				owner => "root", group => "root",
				mode => 555, ensure => present,
				notify => Service[munin-node];

			"/etc/my.cnf":
				source => "puppet:///userserver/my.cnf",
				owner => root, group => root,
				mode => 444, ensure => present;

                       "/usr/local/bin/sgeperl":
                                ensure => link,           
                                owner => root,
                                group => root, 
                                target => "/usr/bin/perl5.14";
		}
	}
}
}
