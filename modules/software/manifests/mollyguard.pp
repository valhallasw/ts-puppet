class software::mollyguard {

case $operatingsystem {

	debian: {
		package {
			molly-guard:
				require => File["molly-guard-rc"];
		}

		file {
			"molly-guard-rc":
				name => "/etc/molly-guard/rc",
                                owner => root, 
				group => root, 
				mode => 644,
				require => File["/etc/molly-guard"],
				source => "puppet:///software/molly-guard-rc";

			"/etc/molly-guard":
				name => "/etc/molly-guard",
				ensure => directory,
                                owner => root, 
                                group => root, 
                                mode => 755;
		}
	}

}
}