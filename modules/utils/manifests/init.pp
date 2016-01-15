define tspkg($ensure = "latest", $dev = "false", $root = "false", $prefix = "TS", $requires = []) {

	# XXX
	if ($hostname == "amaranth") {
		$source = "/export/packages/i386"
		$mountfs = []
	} else {
		$source = "/install/pkgs/custom/i386"
		$mountfs = [Mount["/install"]]
	}

	case $root {
		true: {
			package { "${prefix}${name}-root":
				adminfile => "puppet",
				ensure => $ensure,
				source => $source,
				require => [File["adminfile"], $mountfs, $requires]
			}
		}
	}
			
	package { "${prefix}$name":
		adminfile => "puppet",
		ensure => $ensure,
		source => $source,
		require => [File["adminfile"], $mountfs, $requires];
	}

	case $dev {
		true: {
			package { "${prefix}${name}-dev":
				adminfile => "puppet",
				ensure => $ensure,
				source => $source,
				require => [File["adminfile"], $mountfs, $requires]
			}
		}
	}
			
}
# Macro to install a patch.

define patch($rev, $require = [], $package = "") {
	# XXX
	if ($hostname == "amaranth") {
		$source = "/export/patches"
		$mountfs = []
	} else {
		$source = "/install/patches/custom"
		$mountfs = [Mount["/install"]]
	}

	exec { "install-patch-$name-$rev":
		command => "/usr/sbin/patchadd -M $source $name-$rev",
		require => $mountfs,
		path => "/usr/bin:/sbin:/usr/sbin",
		unless =>
"test ! -z \"$package\" -a ! -d /var/sadm/pkg/$package && exit 0
installed=`showrev -p | sort | grep \"^Patch: $name-\" | tail -1 | cut -d' ' -f 2`
test -z \"\$installed\" && exit 1
ir=`echo \$installed | cut -c8-9`
test \"\$ir\" -lt \"$rev\" && exit 1
exit 0",
		cwd => "/",
		timeout => 3600
	}
}

class utils {
}
