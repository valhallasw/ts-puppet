import "*"

class bsdlogin inherits freebsd {
	include bsdlogin::mounts
	include bsdlogin::files
	include bsdsoftware::user

	file {
		"/etc/motd":
			owner => root, group => wheel, mode => 444,
			source => "puppet:///loginserver/motd";
	}
}
