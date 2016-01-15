class database::xtrabackup {

	exec {
		"apt-add-percona-key":
			command => "gpg --keyserver  hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && gpg -a --export CD2EFD2A | sudo apt-key add -",
			path => "/usr/bin",
			refreshonly => true;
	}

	file {
		"/etc/apt/sources.list.d/percona.list":
			name => "/etc/apt/sources.list.d/percona.list",
			owner => root,
			group => root,
			mode => 644,
			notify => [Exec["apt-get-update"], Exec["apt-add-percona-key"]],
		        source => "puppet:///database/apt_percona-rep";
	}

	package {
		"percona-xtrabackup":
			require => File["/etc/apt/sources.list.d/percona.list"];
	}

}