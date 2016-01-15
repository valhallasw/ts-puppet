class webserver::zws {
	logadm {
		"/var/log/http/access":
			ensure => present, owner => root, group => root,
			count => 7, period => 1d, compress_count => 0;

		"/var/log/http/errors":
			ensure => present, owner => root, group => root,
			count => 7, period => 1d, compress_count => 0;

		"/var/log/http/cgi_errors":
			ensure => present, owner => root, group => root,
			count => 7, period => 1d, compress_count => 0;
	}

        file {
                "/opt/local/bin/do_expired.sh":
                        owner => root, group => root, mode => 555,
                        source => "puppet:///webserver/do_expired.sh";
	}

        cron { 
                do-expired:
                        command => "/opt/ts/bin/cronjob -f root -Ec '/opt/local/bin/do_expired.sh'",
                        user => root,
                        minute => 0, hour => 0;
	}

	include munin::zws
	include tomcat
}
