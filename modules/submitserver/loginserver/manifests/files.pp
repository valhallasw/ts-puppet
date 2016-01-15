class loginserver::files {
	file {
		"/etc/motd":
			source => "puppet:///loginserver/motd",
			owner => "root", group => "root",
			mode => 444, ensure => present;
	}
}
