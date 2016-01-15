import "*"

class esams::files {
	file {
                "/etc/resolv.conf":
			owner => root, group => root, mode => 444,
                        source => "puppet:///esams/resolv.conf.external";

                "puppet.conf":
                        name => "/etc/puppet/puppet.conf",
			owner => root, group => root, mode => 444,
                        source => "puppet:///esams/puppet.conf.$operatingsystem";
	}
}
