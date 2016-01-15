import "utils"

# Provides the GNU userland.  Generally this is only installed
# on login servers.
class software::gnu {
	tspkg {
		coreutils: require => Tspkg[texinfo];
		diffutils: ;
		findutils: ;
		grep: ;
		sed: ;
		gawk: ;
	}
}
