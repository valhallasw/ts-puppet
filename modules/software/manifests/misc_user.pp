import "utils"

# Software that is only needed by users, i.e. on login servers.
class software::misc_user {
	case $operatingsystem {
		debian: {
			package {
				ack-grep: ;
				# For htpasswd, see [[TS-1601]].
				apache2-utils: ;
				curl: ;
				dialog: ;
				emacs: ;
				finger: ;
				git-svn: ;
				gnuplot-nox: ;
				graphicsmagick: ;
				irssi: ;
				libav-tools: ;
				lzip: ;
				lzma: ;
				mc: ;
				netcat6: ;
				p7zip: ;
				p7zip-full: ;
				poppler-utils: ;
				quota: ;
				rlwrap: ;
				rrdtool: ;
				socat: ;
				sqlite3: ;
				#Vim has own class.
#				unzip: ;
				zbar-tools: ;
				zip: ;
				zsh: ;
			}

		}
		solaris: {
			tspkg {
				# Libraries
				boost139: dev => true;
				boost139-gcc: dev => true;
				boost141: dev => true;
				boost142-gcc: ;
				libatk1: dev => true, ensure => absent;
				atk: ;
				libcairomm10: dev => true, ensure => absent;
				cairomm: require => Tspkg[libcairomm10];
				csslint: ensure => absent;
				libcroco3: dev => true, ensure => absent;
				libcroco: require => [Tspkg[libcroco3], Tspkg[csslint]];
				libctemplate0: dev => true, ensure => absent;
				ctemplate: ;
				libexpat1: dev => true;
				libfasttime:;
				libfcgi0: dev => true;
				libfontconfig1: dev => true, root => true, ensure => absent;
				fontconfig: root => true, require => Tspkg[libfontconfig1];
				libfreetype6: dev => true, ensure => absent;
				freetype: require => Tspkg[libfreetype6];
				libgc1: dev => true, ensure => absent;
				gc: require => Tspkg[libgc1];
				libglib2: dev => true, ensure => absent;
				glib2: require => Tspkg[libglib2];
				libgsf1: dev => true, ensure => absent;
				gsf: ensure => absent;
				libgsf: ;
				gdk-pixbuf: require => Tspkg[gtk2];
				libgtk2: dev => true, root => true, ensure => absent;
				gtk2: require => Tspkg[libgtk2];
				mwm: ensure => absent;
				openmotif-dev: ensure => absent;
				openmotif-libs: ensure => absent;
				openmotif: require => [Tspkg[mwm], Tspkg[openmotif-dev], Tspkg[openmotif-libs]];
				libjasper1: dev => true;
				liblcms1: dev => true, ensure => absent;
				lcms-utils: ensure => absent;
				lcms: ;
				libldap-24: dev => true, root => true, ensure => absent;
				openldap-utils: ensure => absent;
				openldap: root => true;
				liblqr1: dev => true, ensure => absent;
				liblqr: ;
				libmysqlpp3: dev => true, ensure => absent;
				libmysqlpp: require => Tspkg[libmysqlpp3];
				libmysqlpp-gcc: ;
				libncurses6: dev => true, ensure => absent;
				libncursesw6: dev => true, ensure => absent;	
				ncurses: require => [Tspkg[libncurses6], Tspkg[libncursesw6], Tspkg[ncurses-utils]];
				libpango1: dev => true, root => true, ensure => absent;
				pango: root => true;
				libpixman1: dev => true, ensure => absent;
				pixman: ;
				libsdl12: dev => true;
				libsigc-20: dev => true, ensure => absent;
				libsigcxx: ;
				libxslt1: dev => true, ensure => absent;
				libxslt-utils: ensure => absent;
				libxslt: require => Tspkg[libxslt1, libxslt-utils];
				libyaz3: dev => true, ensure => absent;
				yaz-utils: ensure => absent;
				yaz: ;
				librsync: ;
				libedit: ;
				libevent: ;
				libevent20: ;
				libogg0: dev => true, ensure => absent;
				libogg: ;
				libvorbis: ;
				libvpx: ;
				leptonlib: ;

				# X11 - required by a lot of other software.
				libICE6: dev => true, ensure => absent;
				libICE: require => Tspkg[libICE6];
				libSM6: dev => true, ensure => absent;
				libSM: require => Tspkg[libSM6];
				libX116: dev => true, ensure => absent;
				libX11: require => Tspkg[libX116];
				libXau6: dev => true, ensure => absent;
				libXau: require => Tspkg[libXau6];
				libXcomposite: ;
				libXdmcp6: dev => true, ensure => absent ;
				libXdmcp: ;
				libXext0: dev => true, ensure => absent;
				libXfixes: ;
				libXrender1: dev => true, ensure => absent;
				libXft2: dev => true, ensure => absent;
				libXft: require => Tspkg[libXft2];
				libXt6: dev => true, ensure => absent ;
				libXt: ;
				libxcb1: dev => true, ensure => absent ;
				libxcb: ;
				libXp6: dev => true ;
				libXext: ;
				libXrender: ;
				x11-bigreqsproto: ;
				x11-inputproto: ;
				x11-kbproto: ;
				x11-pthread-stubs: ;
				x11-renderproto: ;
				x11-xcb-proto: ;
				x11-xcmiscproto: ;
				x11-xextproto: ;
				x11-xproto: ;
				x11-printproto: ;
				x11-xbitmaps: ;
				x11-xtrans: ;
				x11-fixesproto: ;
				x11-compositeproto: ;
		
				# Applications
				anacron: ;
				cabextract: ;
				emacs: ;
				git-python26: ensure => absent;
				git-python27: ;
				gnuplot: require => Tspkg[texinfo];
				isaexec: ;
				jasper-utils: ;
				links: ;
				mbuffer: ;
				ncurses-utils: ensure => absent;
				netcat: ;
				tofrodos: ;
				w3m: ;
				utils: ;
				awffull: ;
				rdiff-backup: ;
				bigloo: ;
				roadsend: root => true;
				tree: ;
				nasm: ;
				webp: ;
				mytop: ;
				gnur: ;
				tesseract: ;
				rlwrap: ;
				gdal: ;
		
				lynx: root => true;
				mono20: root => true;
				xpdf-utils: root => true;
				mc: root => true;
				irssi-dev: ensure => absent;
				irssi: root => true;
	
				libdb47: dev => true, ensure => absent;
				libdb47-util: ensure => absent;
				db47: require => [Tspkg[libdb47], Tspkg[libdb47-util]];
	
				libdjvulibre21: dev => true, ensure => absent;
				djvulibre-utils: ensure => absent;
				djvulibre: require => [Tspkg[libdjvulibre21], Tspkg[djvulibre-utils]];

				libgd2-dev: ensure => absent;
				libgd2-util: ensure=>absent;
				libgd2: require => [Tspkg[libgd2-dev], Tspkg[libgd2-util]];

				exiv2: ;
				nodejs: ;
			}

		
			# rrdtool graphing tool - libraries
			tspkg {
				tcl85-rrd: ;
		        	perl510-rrd: ensure => absent;
		        	perl512-rrd: ;
		        	python26-rrd: ensure => absent;
				python27-rrd: ;
				ruby19-rrd: ;
			}

			# VIPS image processing system
			tspkg {
				libvips15: dev => true, ensure => absent;
				vips: require => Tspkg[libvips15];
				python26-vips: ensure => absent;
				python27-vips: ;
			}

			# Graphviz graphing system
			tspkg {
				graphviz: ;
		        	python26-graphviz: ensure => absent;
				python27-graphviz: requires => Tspkg[python26-graphviz];
		        	perl512-graphviz: ;
				ruby19-graphviz: ;
				php53-graphviz: ;
			}

			# rtorrent
			tspkg {
				libtorrent012: dev => true, ensure => absent;
				libtorrent: require => Tspkg[libtorrent012];
				rtorrent: ;
			}

			# GeoIP
			tspkg {
				libgeoip1: dev => true, root => true, ensure => absent;
				geoip-utils: ensure => absent;
				geoip: require => [Tspkg[libgeoip1], Tspkg[geoip-utils]];
			}
		}
	}

# A identd, used for PostgreSQL among other things
	case $operatingsystem {
                debian: {
			package {
				oidentd: 
					require => Group[oidentd-group];
			}

                        group {
                                oidentd-group:
                                        name => "oident",
					gid => 212,
                                        ensure => present;
                        }			



		}
		solaris: {
                        tspkg {
                                pidentd: root => true;
                        }
                
                        file {
                                "identd.conf":
                                        require => [File["/etc/opt/ts"], Package["TSpidentd-root"]],
                                        name => "/etc/opt/ts/identd.conf", owner => root, group => sys, mode => 444,
                                        source => "puppet:///base/identd.conf";
                        }
                
                        service {
                                "svc:/network/ts/identd:default":
                                        ensure => running,
                                        subscribe => File["identd.conf"],
                                        require => File["identd.conf"];
                        }
		}
	}
}

