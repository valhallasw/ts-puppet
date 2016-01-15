import "*"
class osm inherits base {
	tspkg { 
		postgres-83-postgis: ;
		postgres-83-hstore-new: ;
		dlmalloc: ;
	 }
	include osm::files
	include osm::apache
	include osm::mounts
	include munin::postgres
	include munin::renderd
}
