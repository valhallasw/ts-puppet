import "utils"

# Used by dsh, below
define nodegroup() {
	file { "/etc/opt/ts/dsh/group/$name":
		require => File["/etc/opt/ts/dsh/group"],
		owner => root, group => root, mode => 444,
		source => "puppet:///base/dsh/$name";
	}
}

include software::sudo

class software::misc_std {
	# This is software that every node should get, which is too
	# small to warrant its own class.  Think carefully before
	# adding software here -- is it really required on *every*
	# system?

	case $operatingsystem {

		debian: {
			package {
				apticron: ;
				apt-listchanges: ;
				bash:;
				# For SGE.
				csh: ;
				debian-keyring: ;
				debconf-utils: ;
				joe:;
				gnupg2:;
				lynx:;
				mysql-client: ;
				mytop: ;
				# To prevent accidental reboots.
				# molly-guard: - Has now its own class. --DaB.
				nano:;
				#Contains "top" and "free".
				procps:;
				puppet:;
				rsync:;
				# screen: - Has now its own class. --DaB.
				#screen:;
				smartmontools:;
				ssh:
					root => true,
					require => Group[ssh-group];
				strace: ;
				unzip: ;
				wget:;
			}

                        group {
                                ssh-group:
                                        name => "ssh",
                                        gid => 208,
                                        ensure => present;
                        }
			
		}

		solaris: {

			tspkg {
				# Libraries that other misc packages need.

				apr: ;
				apu: ;
				libapr1: dev => true, ensure => absent;
				libaprutil1: dev => true, ensure => absent;
				rrdtool: ;
				librrd4: dev => true, ensure => absent;	
				libslang2: dev => true, ensure => absent;
				slang: ;
				libpcre0: dev => true, ensure => absent;
				pcre: ;
				libiconv2: dev => true, ensure => absent;
				libiconv: require => Tspkg[libiconv2];
				libpng12: dev => true, ensure => absent;
				libpng: ;
				libpng14: require => Tspkg[libpng];
				libjpeg7: dev => true, ensure => absent;
				libjpeg7-utils: ensure => absent;
				jpeg: ;
				libicu42: dev => true, ensure => absent;
				libicu42-gcc: dev => true, ensure => absent;
				icu: ;
				icu-gcc: ;
				libtiff3: dev => true, ensure => absent;
				libtiff3-utils: ensure => absent;
				libtiff: ;
				libreadline5: dev => true, ensure => absent;
				readline: ;
				libcairo2: dev => true, ensure => absent;
				cairo: requires => Tspkg[libcairo2];
				openssl: ;
				libpcap: ;
				sasl2: ;
		
				which: ;
		
				libgdbm3: dev => true, ensure => absent;
				gdbm: require => Tspkg[libgdbm3];
		
				libintl8: dev => true, ensure => absent;
				libasprintf0: dev => true, ensure => absent;
				emacs-gettext: ensure => absent;
				gettext: require => [Tspkg[libintl8], Tspkg[libasprintf0], Tspkg[emacs-gettext]];
		
				gcc45: ensure => absent;
				gcc46: ensure => present, require => Tspkg[gcc45];
				libxml2: require => [Tspkg[libxml2-dev], Tspkg[libxml-utils]];
				libxml2-dev: ensure => absent;
				libxml-utils: ensure => absent;
		
				# Secure Shell server
				[sshcu, sshdr, sshdu, sshr, sshu]: prefix => SUNW, ensure => absent;
				openssh: root => true;
				# A commonly used shell, and the default for users.
				bash: ;
				# A shell for river ;-)
				zsh: ;
				# Generates passwords.
				pwgen: ;
				# Lots of people create archives in GNU format.
				gtar: require => Tspkg[texinfo];
				# DTraceToolkit, useful for performance analysis.
				dtt: ;
				# Monitor network use
				nicstat: ;
				# Standard tex editor
				vim: root => true;
				# DaB's editor
				joe: root => true;
				# Mazder at least likes this one
				nano: require => Tspkg[texinfo];
				# Mail reader
				mutt: root => true;
				# Used for copying files around
				rsync: root => true;
				# Manages the Sun RAID card
				arcconf: ;
				# All servers need this
				puppet-root: ensure => absent;
				puppet: require => Tspkg[puppet-root];
				# Some utilities for downloading files
				wget: root => true;
				lftp: root => true;
				libcurl4: dev => true, ensure => absent;
				curl: ;
				# Patch management
				pca: ;
				# Tune TCP for large data transfers
				tcptune: ;
				# Used for database dumps among other things
				gnupg: ;
				# Always useful
				screen: ;
				# Installs info files
				texinfo: ;
				# MySQL client; used basically everywhere
				libmysqlclient16: dev => true, ensure => absent;
				mysql51-client: require => Tspkg[libmysqlclient16];
				mysql55-client: ;
				# For Munin
				top: ;
				# Compression tools
				xz: ;
				# nfile, better version of /usr/bin/file
				file: ;
			}
		
			# Ganglia monitoring system
			tspkg {
				libconfuse0: dev => true, ensure => absent;
				libconfuse: ;
				libganglia312: dev => true, ensure => absent;
				ganglia: root => true, ensure => absent;
				ganglia-gmetad: root => true, ensure => absent;
			}
		
			file {
				"/etc/opt/ts/ganglia":
					require => File["/etc/opt/ts"],
					owner => root, group => root, mode => 755, ensure => directory;
				"/etc/opt/ts/ganglia/gmond.conf":
					ensure => absent;
			}
			
			# dsh
			file {
				"/etc/opt/ts/dsh":
					owner => root, group => root, mode => 755,
					ensure => directory, require => Tspkg["dsh"];
				"/etc/opt/ts/dsh/group":
					owner => root, group => root, mode => 755,
					ensure => directory;
				"/etc/opt/ts/dsh/dsh.conf":
					owner => root, group => root, mode => 444,
					source => "puppet:///base/dsh/dsh.conf";
				"/etc/opt/ts/dsh/machines.list":
					owner => root, group => root, mode => 444,
					source => "puppet:///base/dsh/machines.list";
			}
		
			tspkg {
				libdshconfig1: dev => true;
				dsh: root => true;
			}
		
			# dsh node groups
			nodegroup {
				[database, linux, login, solaris]:
			}
		
			# At least Python and subversion require SQLite.
			tspkg {
				libsqlite3: dev => true, ensure => absent;
				sqlite: ;
			}
	
			# Packages that used to be installed, but we no longer want.
			tspkg { "addlog": ensure => absent }
		
			tspkg { ["Tiff-devel-share", "Tiff-devel", "Tiff",
				 "jpg-devel-share", "jpg-devel", "jpg",
				 "png-devel-share", "png-devel", "png",
				 "icud"]:
					prefix => SUNW, ensure => absent;
			}
		
			file {
				"/etc/opt/ts/ssl": ensure => directory;
				"/etc/opt/ts/ssl/openssl.cnf":
					owner => root, group => root, mode => 0444,
					source => "puppet:///software/openssl.cnf";
			}
		
			# ImageMagick
			tspkg {
				imagemagick: ;
				imagemagick-doc: ensure => absent;
				libmagickcore2: dev => true, ensure => absent;
				libmagickpp2: dev => true, ensure => absent;
				libmagickwand2: dev => true, ensure => absent;
			}
		
			tspkg {
				librsvg2: dev => true, ensure => absent;
				rsvg: ensure => absent;
				librsvg: require => [Tspkg[librsvg2], Tspkg[rsvg]];
			}

		}
	}
}
