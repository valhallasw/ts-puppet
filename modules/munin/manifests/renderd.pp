class munin::renderd {
	munin-plugin {
		# mod_tile
		mod_tile_fresh: ;
		mod_tile_response: ;
		mod_tile_zoom: ;

		# database replication
		replication_delay2: ;

		# Tirex
		tirex-status-active-requests: ;
		tirex-status-queued-requests: ;
		tirex-status-queued-requests-age: ;
		tirex-status-render-time: ;
		tirex-status-render-time-default: plugin => tirex-status-render-time;
		tirex-status-render-time-hikebike: plugin => tirex-status-render-time;
		tirex-status-requests-rendered: ;
		tirex-status-requests-rendered-default: plugin => tirex-status-requests-rendered;
		tirex-status-requests-rendered-hikebike: plugin => tirex-status-requests-rendered;

		# Apache
		apache_accesses: ;
		apache_processes: ;
		apache_volume: ;
	}

	tspkg {
		munin-plugin-renderd: notify => Service[munin-node];
	}

	file { "/etc/opt/ts/munin/plugin-conf.d/osm":
		owner => root, group => root, mode => 444,
		notify => Service["munin-node"],
		source => "puppet:///munin/osm";
	}

	# PostgreSQL monitoring
	munin-plugin {
		postgres_cache_osm_mapnik: plugin => postgres_cache_;
		postgres_checkpoints: ;
		postgres_connections_osm_mapnik: plugin => postgres_connections_;
		postgres_locks_osm_mapnik: plugin => postgres_locks_;
		postgres_querylength_osm_mapnik: plugin => postgres_querylength_;
		postgres_scans_osm_mapnik: plugin => postgres_scans_;
		postgres_size_osm_mapnik: plugin => postgres_size_;
		postgres_transactions_osm_mapnik: plugin => postgres_transactions_;
		postgres_tuples_osm_mapnik: plugin => postgres_tuples_;
	}	
}
