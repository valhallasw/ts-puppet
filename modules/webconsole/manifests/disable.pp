class webconsole::disable inherits webconsole {
        Service["svc:/system/webconsole:console"] {
                ensure => stopped
	}
}
