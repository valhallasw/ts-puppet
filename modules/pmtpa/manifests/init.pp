class pmtpa {
	file {
                "/etc/resolv.conf":
                        source => "puppet:///pmtpa/resolv.conf";

                "puppet.conf":
                        name => "/etc/puppet/puppet.conf",
                        source => "puppet:///pmtpa/puppet.conf";
	}
}
