import "*"

class database {

case $operatingsystem {

        debian: {

		package {
			"mysql-server-5.1": ;
		}

		file {
			"/sql/":
				ensure => directory,
				owner => root,
				group => mysql,
				mode => 750;
		}

		include database::xtrabackup
		include database::munin
		include database::backupuserdbs

	}

	solaris: {

	$bindir = $operatingsystem ? {
		freebsd => '/usr/local/bin',
		solaris => '/opt/local/bin'
	}

	$group = $operatingsystem ? {
		freebsd => 'wheel',
		solaris => 'root'
	}

	file {
		"$bindir/refresh-ts-db":
			require => File["$bindir"],
			owner => root, group => $group, mode => 555,
			source => "puppet:///database/refresh-ts-db";

		"$bindir/run-user-db-backups":
			require => File["$bindir"],
			owner => root, group => $group, mode => 555,
			source => "puppet:///database/run-user-db-backups.Solaris";

		"$bindir/kill-queries":
			require => File["$bindir"],
			owner => root, group => $group, mode => 555,
			source => "puppet:///database/kill-queries";
	}

	cron {
		refresh-ts-db:
			command => $operatingsystem ? {
				freebsd => "$bindir/refresh-ts-db",
				solaris => "/opt/ts/bin/cronjob -f root -Ec '/opt/local/bin/refresh-ts-db'"
			},
			user => root,
			hour => 3,
			minute => 0,
			ensure => absent;

		run-user-db-backups:
			command => $operatingsystem ? {
				freebsd => "$bindir/run-user-db-backups",
				solaris => "/opt/ts/bin/cronjob -f root -Ec '/opt/local/bin/run-user-db-backups'",
			},
			user => root,
			hour => 3,
			minute => 30;

		remove-ips:
			command => $operatingsystem ? {
				freebsd => "/shared/bin/remove-ips",
				solaris => "/opt/ts/bin/cronjob -f root -Ec '/shared/bin/remove-ips'",
			},
			user => root,
			hour => 1,
			minute => 30;
	}

	include database::munin
}
}
}
