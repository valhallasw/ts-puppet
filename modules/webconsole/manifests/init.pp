class webconsole {
	service { "svc:/system/webconsole:console":
		ensure => stopped
	}
}
