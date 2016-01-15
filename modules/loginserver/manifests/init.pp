class loginserver {
	include loginserver::files
	include loginserver::motd

	case $operatingsystem {
		debian: {
			# Print quota information if quota exceeded.
			file { "/etc/profile.d/quota.sh":
				source => "puppet:///loginserver/profile-d-quota.sh",
				owner => "root",
				group => "root",
				mode => 755,
				ensure => present;
			}
		}
	}
}
