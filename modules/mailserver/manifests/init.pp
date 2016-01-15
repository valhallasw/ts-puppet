import "*"
class mailserver {
	include mailserver::packages
	include mailserver::files

        cron { 
                run-sa-update:
                        command => "/opt/ts/bin/cronjob -f root -Ec '/opt/local/bin/run_sa_update'",
                        user => root,
                        hour => 0, minute => 0, ensure => absent;
	}
}
