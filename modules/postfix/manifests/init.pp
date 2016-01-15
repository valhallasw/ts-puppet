class postfix {

	$bindir = $operatingsystem ? {
		debian => "/usr/sbin/", 
                solaris => "/opt/ts/bin"
	}

	$confdir = $operatingsystem ? {
                debian => "/etc/postfix/",
                solaris => "/etc/opt/ts/postfix"
	}

	$postfixpackage = $operatingsystem ? {
                debian => Package[postfix],
                solaris => Tspkg[postfix]
	}

        $aliasbin = $operatingsystem ? {
                debian => "/usr/bin/newaliases",
		solaris => "/opt/ts/bin/newaliases"
	}

	$group = "root"

	group { 
		"postfix": 
			gid => $operatingsystem ? {
				debian => 202,
				solaris => 102
			},
			ensure => present;

		"postdrop": 
                        gid => $operatingsystem ? {
                                debian => 203,
                                solaris => 103
                        },
                        ensure => present;
	}

	user { "postfix":
		uid => $operatingsystem ? {
                        debian => 202,
                	solaris => 102
		},
                gid => $operatingsystem ? {   
                        debian => 202,        
                        solaris => 102          
                },
		comment => "Postfix user",
		home => "/var/spool/postfix", shell => "/bin/false",
		ensure => present, require => Group[postfix];
	}


	case $operatingsystem {
	
		debian: {
			package {
				postfix:
					require => User[postfix],
					notify => Service["postfix"];

				postfix-ldap:
					require => [User[postfix],Package[postfix]];

				exim4:
					ensure => purged;
			}


		}

		solaris: {
			tspkg { 
				"postfix-root": ensure => absent;
				"postfix":
					require => [User[postfix], Group[postfix], Group[postdrop], Tspkg[postfix-root]],
					notify => Service["postfix"];
			}
		}
	}



	# Replace sendmail with postfix
	case $operatingsystem {
		solaris: {
			file {
				"/usr/lib/sendmail": ensure => "/opt/ts/sbin/sendmail";
				"/usr/sbin/newaliases": ensure => "$aliasbin";
				"/usr/bin/mailq": ensure => "/opt/ts/bin/mailq";
			}
		}
	}
	
      case $operatingsystem {
		
		debian: {
			service {
				"postfix":
					name => "postfix",
					ensure => running,
                                        require => [$postfixpackage, File["$confdir/main.cf"], File["$confdir/master.cf"]];
			}
		}
		solaris: {
			service {
				# Ensure sendmail is not running
				"svc:/network/smtp:sendmail": ensure => stopped;
				"svc:/network/sendmail-client:default": ensure => stopped;
		
				# Start Postfix
				"postfix":
					name => "svc:/network/postfix:default",
					ensure => running,
					require => [$postfixpackage, File["$confdir/main.cf"], File["$confdir/master.cf"]];	
			}

		        exec {
		                "postfix-initial-newaliases":
		                        command => "$aliasbin",
		                        require => $postfixpackage,
                	        creates => "/etc/mail/aliases.dir";
			}
		}
	}



	exec {
		"postfix-newaliases":
			command => "$aliasbin",
			require => $postfixpackage,
			refreshonly => true;
	}

	Mailalias {
		notify => Exec[postfix-newaliases],
		require => $postfixpackage
	}

	mailalias {
		"root": recipient => admins;
		"nobody": recipient => "root";
		"cron": recipient => "root";
		"daemon": recipient => "root";
		"mysql": recipient => "root";
		"slayerd": recipient => "root";
		"watcherd": recipient => "root";
		"audit_warn": recipient => "root";

		# Admin users
		"rriver": recipient => "river.tarnell@wikimedia.de";
		"rdaniel": recipient => "daniel.kinzler@wikimedia.de";
		"rdab": recipient => "dab@wikimedia.de";
		"ravar": recipient => "avar@toolserver.org";
		"rreedy": recipient => "reedy@toolserver.org";
		"rsimetrical": recipient => "simetrical@toolserver.org";
		"rtstarling": recipient => "tstarling@wikimedia.org";
		"rwerdna": recipient => "werdna@toolserver.org";
		"rnosy": recipient => "marlen.caemmerer@wikimedia.de";
	}

	file {
		"$confdir/main.cf":
			owner => root, group => $group, mode => 644, ensure => present,
			content => template("postfix/main.cf.erb.$operatingsystem"),
			require => $postfixpackage,
			notify => Service[postfix];
		"$confdir/master.cf":
			owner => root, group => root, mode => 644, ensure => present,
			source => "puppet:///postfix/master.cf",
			require => $postfixpackage,
			notify => Service[postfix];
		"$confdir/ldap-aliases.cf":
			owner => root, group => root, mode => 644, ensure => present,
			source => "puppet:///postfix/ldap-aliases.cf",
			require => $postfixpackage,
			notify => Service[postfix];

	}

	include munin::postfix
}
