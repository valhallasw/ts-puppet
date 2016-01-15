class ipfilter::disable inherits ipfilter {
        Service["svc:/network/ipfilter:default"] {
                ensure => stopped
	}
}
