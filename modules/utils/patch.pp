# Macro to install a patch.

define patch($rev, $require = [], $package = "") {
	exec { "install-patch-$name-$rev":
		command => "/usr/sbin/patchadd -M /install/patches/custom $name-$rev",
		require => Mount["/install"],
		path => "/usr/bin:/sbin:/usr/sbin",
		unless =>
"[ ! -z \"$package\" -a ! -d /var/sadm/pkg/$package ] && exit 0
installed=`showrev -p | sort | grep \"^Patch: $name-\" | tail -1 | cut -d' ' -f 2`
[ -z \"\$installed\" ] && exit 1
ir=`echo \$installed | cut -c8-9`
[ \"\$ir\" -lt \"$rev\" ] && exit 1
exit 0",
		cwd => "/",
		timeout => 3600
	}
}

