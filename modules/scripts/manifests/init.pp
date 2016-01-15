class scripts {
	$prefix = $operatingsystem ? {
		debian => "/usr/local",
		freebsd	=> "/usr/local",
		solaris	=> "/opt/local"
	}

	$group = $operatingsystem ? {
		debian => "root",
		freebsd	=> "wheel",
		solaris	=> "root"
	}

	$bindir = "$prefix/bin"

	file { 
		"$prefix": 
			owner => root, group => $group, mode => 755,
			ensure => directory;

		"$bindir": 
			require => File["$prefix"],
			owner => root, group => $group, mode => 755,
			ensure => directory
	}
}
