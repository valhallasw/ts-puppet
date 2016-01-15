class solaris::files {
	# Logfiles
	file { ["/var/log/authlog",
		"/var/log/syslog",
		"/var/log/maillog",
		"/var/adm/messages"]:
			owner => root,
			group => sys,
			mode => 640,
			ensure => present;

		"/var/log/userlog":
			owner => root,
			group => sys,
			mode => 644,
			ensure => present
	}

	# Special files associated with a daemon
	file {
		"syslog.conf":
			name => "/etc/syslog.conf", owner => root, group => root, mode => 444,
			source => "puppet:///solaris/syslog.conf";

		"ndpd.conf": 
			name => "/etc/inet/ndpd.conf", owner => root, group => root, mode => 444,
			source => "puppet:///solaris/ndpd.conf";

		"nscd.conf":
			name => "/etc/nscd.conf", owner => root, group => root, mode => 444,
			source => "puppet:///solaris/nscd.conf",
			notify => Service["svc:/system/name-service-cache:default"];

		"snmp.conf":
			name => "/etc/sma/snmp/snmp.conf", owner => root, group => root, mode => 444,
			source => "puppet:///solaris/snmp.conf";

		"snmpd.conf":
			name => "/etc/sma/snmp/snmpd.conf", owner => root, group => root, mode => 400,
			source => "puppet:///modules/secret/solaris/snmpd.conf";

		"/etc/opt/ts":
			owner => root, group => sys, mode => 755, ensure => directory;

		"pam.conf":
			name => "/etc/pam.conf", owner => root, group => root, mode => 444,
			source => "puppet:///solaris/pam.conf";

		"/etc/profile": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/profile";

		"/etc/default/login": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/login";

		"/etc/default/cron": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/cron";
	
		"/etc/bash.bashrc": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/bash.bashrc";

		"/etc/ldap.secret": 
			owner => root, group => root, mode => 400,
			source => "puppet:///modules/secret/ldap/ldap.secret";

		"pam_list.conf": 
			name => "/etc/pam_list.conf",
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/pam_list.conf";

		"/etc/shells": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/shells";

	### Terminfo
		"/usr/share/lib/terminfo/c/cons25-iso-m": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25-iso-m";

		"/usr/share/lib/terminfo/c/cons25": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25";

		"/usr/share/lib/terminfo/c/cons25-iso8859": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25-iso8859";

		"/usr/share/lib/terminfo/c/cons25-koi8-r": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25-koi8-r";

		"/usr/share/lib/terminfo/c/cons25-koi8r-m": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25-koi8r-m";

		"/usr/share/lib/terminfo/c/cons25-m": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25-m";

		"/usr/share/lib/terminfo/c/cons25l1": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25l1";

		"/usr/share/lib/terminfo/c/cons25l1-m": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25l1-m";

		"/usr/share/lib/terminfo/c/cons25r": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25r";

		"/usr/share/lib/terminfo/c/cons25r-m": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/cons25r-m";

		"/usr/share/lib/terminfo/r/rxvt-unicode": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/rxvt-unicode";

		"/usr/share/lib/terminfo/r/rxvt": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/rxvt";

		"/usr/share/lib/terminfo/s/screen": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/screen";

		"/usr/share/lib/terminfo/x/xterm": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/xterm";

		"/usr/share/lib/terminfo/x/xterm-color": 
			owner => root, group => root, mode => 444,
			source => "puppet:///solaris/terminfo/xterm-color";

	### /var
		"adminfile":
			name => "/var/sadm/install/admin/puppet", owner => root, group => root, mode => 444,
			source => "puppet:///solaris/adminfile";

	# Some programs (mostly script interpreters) are expected to be found
	# in /usr/bin, but we install them into /opt/ts.  Create symlinks so
	# users can find them.  We create one set of versioned symlinks to
	# the real program, e.g. python2.6 -> /opt/ts/python/2.6/bin/python,
	# and another with the non-versioned name, e.g. python -> python2.6.
		"/usr/bin/bash":	ensure => "/opt/ts/bin/bash";
		"/usr/bin/zsh":		ensure => "/opt/ts/bin/zsh";
		"/usr/bin/tclsh8.5":	ensure => "/opt/ts/tcl/8.5/bin/tclsh8.5";
		"/usr/bin/tclsh":	ensure => "tclsh8.5";


	# Solaris ships some programs in /usr/sfw/bin, but we install our own
	# versions instead in /opt/ts/bin.  Some third-party software expects
	# the /usr/sfw/bin version to be there, so create symlinks.
		"/usr/sfw/bin/gtar":	ensure => "/opt/ts/bin/gtar";
		"/usr/sfw/bin/wget":	ensure => "/opt/ts/bin/wget";
	}

	# MNT-186, fix typo in /etc/security/prof_attr
	exec { "fix-jobs-rbac":
		command => "sed 's/solaris.jobs.users/solaris.jobs.user/g' </etc/security/prof_attr >/etc/security/prof_attr.new && mv /etc/security/prof_attr.new /etc/security/prof_attr",
		onlyif => "grep solaris.jobs.users /etc/security/prof_attr",
		path => "/usr/bin:/sbin:/usr/sbin"
	}
}
