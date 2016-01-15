class cronie::munin {

	# The plugin.
        file {
                munin-cronjobs:
                        name => "/etc/opt/ts/munin/plugins/cron_jobs.sh",
                        owner => root,
                        group => munin,
                        mode => 755,
			require => File["munin-cronjobs-config"],
                        notify => Service["munin-node"],
                        source => "puppet:///modules/cronie/cron_jobs.sh";
        }


        # The plugin-config.
        file {
                munin-cronjobs-config:
                        name => "/etc/opt/ts/munin/plugin-conf.d/cron_jobs",
                        owner => root, 
                        group => admins,
                        mode => 644,
			notify => Service["munin-node"],
                        source => "puppet:///modules/cronie/cron_jobs-config";
	}
}
