class webconsole::enable inherits webconsole::disable {
	Service["svc:/system/webconsole:console"] {
                ensure => running
	}
}
