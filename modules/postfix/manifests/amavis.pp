# Postfix instance that does amavis scanning
class postfix::amavis inherits postfix::user {
	tspkg {
		amavisd-new: require => Tspkg[spamassassin];
		spamassassin: root => true;
	}

	File["/etc/opt/ts/postfix/master.cf"] {
		source => "puppet:///postfix/master.cf.amavis"
	}

	file {
		"/etc/opt/ts/amavisd.conf":
			require => Tspkg[amavisd-new],
			owner => root, group => root, mode => 0644,
			content => template("postfix/amavisd.conf.erb"),
			notify => Service[amavisd];
		"/var/amavis":
			require => [Group[vscan], User[vscan]],
			ensure => directory, owner => vscan, group => vscan,
			mode => 0700;
		"/var/amavis/db":
			require => [Group[vscan], User[vscan], File["/var/amavis"]],
			ensure => directory, owner => vscan, group => vscan,
			mode => 0700;
	}
	
	group {
		"vscan": ensure => present, gid => 106;
	}

	user {
		"vscan": 
			ensure => present, comment => "Mail scanner", 
			require => Group[vscan],
			gid => "vscan", home => "/var/amavis",
			managehome => false, shell => "/bin/sh",
			uid => 106;
	}

	service {
		"amavisd":
			name => "svc:/network/ts/amavisd:default",
			ensure => running, require => File["/var/amavis/db"];
	}
}
