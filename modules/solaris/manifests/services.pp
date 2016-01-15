class solaris::services {
	file { "/var/svc/manifest/network/rwhod.xml":
		owner => root, group => root, mode => 644, ensure => present,
		source => "puppet:///base/rwhod.xml"
	}

	if ($virtual == "zone") {
		# zones don't/can't use bootadm
		cron { bootarchive:
			command => "/opt/ts/bin/cronjob -f root -Ec '/sbin/bootadm update-archive'",
			user => root,
			minute => 0,
			ensure => absent;
		}
	} else {
		# Update the boot archive hourly.  This prevents boot failures when a file
		# in the archive is updated but bootadm isn't run.
		cron { bootarchive:
			command => "/opt/ts/bin/cronjob -f root -Ec '/sbin/bootadm update-archive'",
			user => root,
			minute => 0;
		}
	}

	cron { 
		# Regenerate manpage index once a day
		catman:
			command => "eval `grep MANPATH /etc/profile`; catman -w >/dev/null 2>&1",
			user => root, minute => 37, hour => 3;
	}

	# We only use SNMP for FMA, which doesn't work in zones.
	if ($virtual == "zone") {
		service { "svc:/application/management/sma:default":
			ensure => stopped;
		}
	} else {
		service { "svc:/application/management/sma:default":
			ensure => running,
			subscribe => File["snmpd.conf"];
		}
	}

	service {
		"svc:/network/ssh:default": 
			ensure => stopped;

		"svc:/network/ts/openssh:default":
			require => [Service["svc:/network/ssh:default"],
				Tspkg[openssh]],
			ensure => running,
			subscribe => File[
				"sshd_config",
				"ssh_host_dsa_key",
				"ssh_host_rsa_key",
				"ssh_host_ecdsa_key"
			];

		"svc:/system/system-log:default":
			ensure => running,
			subscribe => File["syslog.conf"],
			require => File["syslog.conf"];

		"svc:/system/name-service-cache:default":
			ensure => running;

		# Services we _don't_ want running
		"svc:/application/graphical-login/cde-login:default":
			ensure => stopped;

		"svc:/system/filesystem/volfs:default":
			ensure => stopped;

		"svc:/application/cde-printinfo:default":
			ensure => stopped;

		"svc:/network/rpc/cde-ttdbserver:tcp":
			ensure => stopped;

		"svc:/network/rpc/cde-calendar-manager:default":
			ensure => stopped;

		"svc:/application/management/wbem:default":
			ensure => stopped;

		"svc:/system/filesystem/autofs:default":
			ensure => stopped;

		# This stuff is disabled by SBD but gets started in a zone
		["svc:/network/rpc-100235_1/rpc_ticotsord:default",
		 "svc:/network/rpc/rstat:default",
		 "svc:/network/rpc/gss:default",
		 "svc:/application/management/seaport:default",
		 "svc:/network/finger:default",
		 "svc:/network/login:rlogin",
		 "svc:/network/rpc/rusers:default",
		 "svc:/network/security/ktkt_warn:default",
		 "svc:/network/shell:default",
		 "svc:/network/telnet:default"]:
			ensure => stopped;

	}
}
