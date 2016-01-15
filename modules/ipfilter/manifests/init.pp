class ipfilter {
	service { "svc:/network/ipfilter:default":
		ensure => stopped
	}
}
