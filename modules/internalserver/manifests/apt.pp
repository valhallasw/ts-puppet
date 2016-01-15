class internalserver::apt inherits debian::apt {
        File ["apt.conf"] 
	{ 
        	source => "puppet:///internalserver/apt.conf"
	}
}
