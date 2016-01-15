class base::puppet {

case $operatingsystem {

        solaris: {
		cron { 
			puppet:
				command => "/opt/ts/bin/cronjob -f root -Ec '/opt/ts/sbin/puppetd --no-daemonize --onetime 2>&1|grep -v \"no such interface\"'",
				user => root,
				minute => fqdn_rand(59);
		}
	}

	debian: {
		service {
			puppet:
				name => puppet,
				require => File["puppet-default"],
				ensure => running;
		}

		file {
			"puppet-default":
				name => "/etc/default/puppet",
				owner => root,
				group => root,
				mode => 644,
				source => "puppet:///base/puppet-default";
		}
	}

}
}

