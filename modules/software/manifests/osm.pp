import "utils"

# OSM software.  This is installed on both login servers and
# the OSM databases.
class software::osm {
	# Required for tile rendering
	include software::fonts

	case $operatingsystem {
		debian: {
			package {
				libgdal1-dev: ; 
				libgeos-dev: ;
				libproj-dev: ;
				libprotobuf6: ;
				libprotobuf-dev: ;
				libsparsehash-dev: ;
				protobuf-compiler: ;
			}
		}

		solaris: {
			tspkg {
				libmapnik06-gcc: dev => true, ensure => absent;
				libmapnik06: dev => true, ensure => absent;
				libmapnik071-gcc-dev: ensure => absent;
				libmapnik071-gcc: require => Tspkg[libmapnik071-gcc-dev];
				osm2pgsql: ensure => absent;
		        	python26-mapnik: ensure => absent;
				python27-mapnik: ;
				libproj0: dev => true, ensure => absent;
				proj4: ;
				geos: require => Tspkg[libgeos311-dev];
				libgeos311-dev: ensure => absent;
			}
		}
	}
}
