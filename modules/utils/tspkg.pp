define tspkg($ensure = "latest", $dev = "false", $root = "false", $prefix = "TS", $requires = []) {
	case $root {
		true: {
			package { "${prefix}${name}-root":
				adminfile => "puppet",
				ensure => $ensure,
				source => "/install/pkgs/custom/i386",
				require => [File["adminfile"], Mount["/install"], $requires]
			}
		}
	}
			
	package { "${prefix}$name":
		adminfile => "puppet",
		ensure => $ensure,
		source => "/install/pkgs/custom/i386",
		require => [File["adminfile"], Mount["/install"], $requires]
	}

	case $dev {
		true: {
			package { "${prefix}${name}-dev":
				adminfile => "puppet",
				ensure => $ensure,
				source => "/install/pkgs/custom/i386",
				require => [File["adminfile"], Mount["/install"], $requires]
			}
		}
	}
			
}
