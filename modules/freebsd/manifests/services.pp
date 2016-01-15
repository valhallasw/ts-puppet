class freebsd::services {
	service {
		"sshd":
			enable => true,
			ensure => running;
	}
}
