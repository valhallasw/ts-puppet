import "utils"

# Packages needed for compiling software
class software::devel {
	case $operatingsystem {	
		debian: {
			package {
				autoconf: ;
				cmake: ;
				build-essential: ;
				gdb: ;
				git: ;
				subversion: ;
			}
		}

		solaris: {
			# GNU software is often required for compilation
			include software::gnu
		
			tspkg {
				# Old Sun SFW GCC
				SUNWbinutils: prefix => "", ensure => absent;
				SUNWgcc: prefix => "", ensure => absent;
		
				# Standard software we need to build other software
				# packages.  It's useful to have these on every host.
				pkgbuild: ;
				pkgconfig: ;
				m4: ;
				autoconf: ;
				automake: ;
				gmake: require => Tspkg[texinfo];
				libtool: ;
				gdb: ;
				binutils: require => Tspkg[texinfo];
				gcc44: ;
				ant: ;
				swig: ;
		 		intltool: ;
				libmpfr1: dev => true, ensure => absent;
				libgmp3: dev => true, ensure => absent;
				mpfr: require => Tspkg[libmpfr1];
				gmp: require => Tspkg[libgmp3];
				mpc: ;
				flex: ;

				libneon27: dev => true, ensure => absent;
				libneon29: dev => true, ensure => absent;
				neon: require => Tspkg[libneon29];
				subversion: require => Tspkg[subversion-dev];
				subversion-dev: ensure => absent;
				git: ;
				hg: ;
				python26-hgsubversion: ensure => absent;
				python27-hgsubversion: ;
				cvs: ;
			}
		}
	}
}
		