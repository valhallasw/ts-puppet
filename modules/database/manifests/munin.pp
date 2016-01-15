class database::munin {
	$confdir = $operatingsystem ? {
		debian => "/etc/munin/plugin-conf.d",
		solaris => "/etc/opt/ts/munin/plugin-conf.d"
	}

	file {
		"$confdir/mysql":
			owner => root, 
			group => root, 
			mode => 644,
			source => "puppet:///database/munin-mysql.$operatingsystem",
			notify => Service["munin-node"],
			require => $operatingsystem ? {
		                debian => [Package['munin-node'],Package['libcache-cache-perl']],
		                solaris => Tspkg[munin-node]
		        };
	}

case $operatingsystem {

	debian:{

                package {
                        "libcache-cache-perl": ;
                }

		munin-plugin {
			mysql_bin_relay_log: plugin => "mysql_";
			mysql_commands: plugin => "mysql_";
			mysql_connections: plugin => "mysql_";
			mysql_files_tables: plugin => "mysql_";
			mysql_innodb_bpool: plugin => "mysql_";
			mysql_innodb_bpool_act: plugin => "mysql_";
			mysql_innodb_insert_buf: plugin => "mysql_";
			mysql_innodb_io: plugin => "mysql_";
			mysql_innodb_io_pend: plugin => "mysql_";
			mysql_innodb_log: plugin => "mysql_";
			mysql_innodb_rows: plugin => "mysql_";
			mysql_innodb_semaphores: plugin => "mysql_";
			mysql_innodb_tnx: plugin => "mysql_";
			mysql_myisam_indexes: plugin => "mysql_";
			mysql_network_traffic: plugin => "mysql_";
			mysql_qcache: plugin => "mysql_";
			mysql_qcache_mem: plugin => "mysql_";
			mysql_replication: plugin => "mysql_"; 
			mysql_select_types: plugin => "mysql_";
			mysql_slow: plugin => "mysql_";
			mysql_sorts: plugin => "mysql_";
			mysql_table_locks: plugin => "mysql_";
			mysql_tmp_tables: plugin => "mysql_";
		}
	}

        solaris:{
                munin-plugin {
                        mysql_bytes: ;
                        mysql_queries: ;
                        mysql_replication: plugin => "mysql_";
                        mysql_network_traffic: plugin => "mysql_";
                        mysql_files_tables: plugin => "mysql_";
                        mysql_innodb_bpool: plugin => "mysql_";
                        mysql_innodb_bpool_act: plugin => "mysql_";
                        mysql_innodb_io: plugin => "mysql_";
                        mysql_innodb_io_pend: plugin => "mysql_";
                }
        }
}

}
