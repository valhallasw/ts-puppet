class submitserver {
	include software::ucarp
	include pdns
	include postfix::amavis

	file {
		"/etc/motd":
			ensure => present, mode => 0644,
			owner => root, group => root,
			source => "puppet:///submitserver/motd";

		"/etc/opt/ts/ucarp": ensure => directory;

		"/etc/opt/ts/ucarp/cron-up.sh":
			ensure => present, mode => 0755,
			owner => root, group => root,
			source => "puppet:///submitserver/cron-up.sh",
			require => File["/etc/opt/ts/ucarp"];
		"/etc/opt/ts/ucarp/cron-down.sh":
			ensure => present, mode => 0755,
			owner => root, group => root,
			source => "puppet:///submitserver/cron-down.sh",
			require => File["/etc/opt/ts/ucarp"];
		"/etc/opt/ts/ucarp/cron.pass":
			ensure => present, mode => 0600,
			owner => root, group => root,
			source => "puppet:///submitserver/cron.pass",
			require => File["/etc/opt/ts/ucarp"];
		"/var/svc/manifest/network/ucarp-cron.xml":
			ensure => present, mode => 0644,
			owner => root, group => root,
			content => template("submitserver/ucarp-cron.xml.erb");
	}

	exec {
		"update-smf":
			command => "svccfg import /var/svc/manifest/network/ucarp-cron.xml",
			path => "/sbin:/usr/sbin:/usr/bin",
			subscribe => File["/var/svc/manifest/network/ucarp-cron.xml"],
			require => File["/var/svc/manifest/network/ucarp-cron.xml"];
	}

	service {
		"svc:/network/ucarp-cron:default":
			ensure => running,
			require => Exec[update-smf];
	}
}
