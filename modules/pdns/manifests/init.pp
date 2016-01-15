class pdns {
	# Recursor
	tspkg {
		pdns-recursor: root => true, ensure => absent;
		pdns: ;
		bind: ;
		wita: ;
	}

	file {
		"named.conf":
			name => "/etc/opt/ts/named.conf",
			owner => root, group => root, mode => 0600,
			notify => Service[named],
			source => "puppet:///pdns/named.conf";
		"/etc/opt/ts/namedb": ensure => directory;
		"/etc/opt/ts/namedb/root.cache":
			owner => root, group => root, mode => 0644,
			source => "puppet:///pdns/root.cache",
			require => File["/etc/opt/ts/namedb"];
	
		"/etc/opt/ts/pdns":
			ensure => directory;
		"pdns.conf":
			name => "/etc/opt/ts/pdns/pdns.conf",
			content => template("pdns/pdns.conf.erb"),
			owner => root, group => root,
	#		notify => Service[pdns],
			require => File["/etc/opt/ts/pdns"];
		"wita.conf":
			name => "/etc/opt/ts/pdns/wita.conf",
			source => "puppet:///pdns/wita.conf",
			owner => root, group => root,
	#		notify => Service[pdns],
			require => File["/etc/opt/ts/pdns"];
		"wita.sh":
			name => "/etc/opt/ts/pdns/wita.sh",
			mode => 0755, require => File["/etc/opt/ts/pdns"],
			owner => root, group => root,
	#		notify => Service[pdns],
			content =>
"#! /bin/ksh
exec /opt/ts/bin/wita -c /etc/opt/ts/pdns/wita.conf";

		"bind.conf":
			name => "/etc/opt/ts/pdns/bind.conf",
			require => File["/etc/opt/ts/pdns"],
			owner => root, group => root,
	#		notify => Service[pdns],
			source => "puppet:///pdns/bind.conf";

		"/etc/opt/ts/pdns/zones":
			ensure => directory;

		"/etc/opt/ts/pdns/zones/1.24.10.in-addr.arpa":
			source => "puppet:///pdns/zones/1.24.10.in-addr.arpa",
			owner => root, group => root,
			require => File["/etc/opt/ts/pdns/zones"];
		"/etc/opt/ts/pdns/zones/db.toolserver.org":
			source => "puppet:///pdns/zones/db.toolserver.org",
			owner => root, group => root,
			require => File["/etc/opt/ts/pdns/zones"];
		"/etc/opt/ts/pdns/zones/fastdb.toolserver.org":
			source => "puppet:///pdns/zones/fastdb.toolserver.org",
			owner => root, group => root,
			require => File["/etc/opt/ts/pdns/zones"];
		"/etc/opt/ts/pdns/zones/rrdb.toolserver.org":
			source => "puppet:///pdns/zones/rrdb.toolserver.org",
			owner => root, group => root,
			require => File["/etc/opt/ts/pdns/zones"];
		"/etc/opt/ts/pdns/zones/userdb.toolserver.org":
			source => "puppet:///pdns/zones/userdb.toolserver.org",
			owner => root, group => root,
			require => File["/etc/opt/ts/pdns/zones"];
		"/etc/opt/ts/pdns/zones/wita.toolserver.org":
			source => "puppet:///pdns/zones/wita.toolserver.org",
			owner => root, group => root,
			require => File["/etc/opt/ts/pdns/zones"];
		"/etc/opt/ts/pdns/zones/www.toolserver.org":
			source => "puppet:///pdns/zones/www.toolserver.org",
			owner => root, group => root,
			require => File["/etc/opt/ts/pdns/zones"];
	}

	service {
		"named":
			name => "svc:network/ts/named:default",
			require => [Tspkg[bind], File["named.conf"]],
			subscribe => Tspkg[bind],
			ensure => running;

		#"pdns":
	#		name => "svc:/network/ts/pdns:default",
	#		require => [Tspkg[pdns], File["pdns.conf"],
	#			File["bind.conf"], Tspkg[wita],
	#			File["wita.conf"], File["wita.sh"]],
	#		ensure => running;
	}
}
