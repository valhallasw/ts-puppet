class clusterserver {
	file {
		"/opt/local/bin/run-ldap-backup":
			owner => root, group => root, mode => 555, ensure => present,
			source => "puppet:///clusterserver/run-ldap-backup";

		"/opt/local/bin/run-svn-backup":
			owner => root, group => root, mode => 555, ensure => present,
			source => "puppet:///clusterserver/run-svn-backup";
	}

        cron { 
                run-svn-backup:
                        command => "/opt/ts/bin/cronjob -f root -Ec '/opt/local/bin/run-svn-backup'",
                        user => root, hour => 3, minute => 35;

                run-ldap-backup:
                        command => "/opt/ts/bin/cronjob -f root -Ec '/opt/local/bin/run-ldap-backup'",
                        user => root, hour => 3, minute => 37;

		# Create a list of svn repositories to mirror on amaranth
		repolist:
			command => "/opt/ts/bin/cronjob -f root -Ec 'ls /global/misc/svn/repos >/global/misc/svn/wwwroot/repolist'",
			user => root,
			minute => 0;
	}
}
