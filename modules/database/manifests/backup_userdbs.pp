class database::backupuserdbs {

	file {
		"/usr/local/lib/run-user-db-backups":
			owner => root,
			group => root,
			mode => 544,
                        source => "puppet:///database/run-user-db-backups.Debian";
	}

	cron { 
		run-user-db-backups:
			command => "/usr/local/lib/run-user-db-backups",
			user    => root,
			hour    => 3,
			minute  => 7;
	}
}

