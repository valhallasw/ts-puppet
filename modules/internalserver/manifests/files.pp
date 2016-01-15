class internalserver::files inherits esams::files {
	File["/etc/resolv.conf"] {
		source => "puppet:///base/resolv.conf.internal"
	}


}
