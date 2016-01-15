class debian::ips {
        file {
                "network-interfaces":
                        name => "/etc/network/interfaces", 
			owner => root, 
			group => root, 
			mode => 644,
                        source => "puppet:///debian/ips-network-interfaces.$hostname";
        }

}
