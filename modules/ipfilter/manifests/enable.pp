class ipfilter::enable inherits ipfilter::disable {
	file { 
		"ipf.conf":
			name => "/etc/ipf/ipf.conf", group => root, owner => root, mode => 400,
			source => "puppet:///ipfilter/$hostname/ipf.conf";

		"ipf6.conf":
			name => "/etc/ipf/ipf6.conf", group => root, owner => root, mode => 400,
			source => "puppet:///ipfilter/$hostname/ipf6.conf";
	}

	Service["svc:/network/ipfilter:default"] {
                ensure => running,
		subscribe => [File["ipf.conf"], File["ipf6.conf"]]
	}
}
