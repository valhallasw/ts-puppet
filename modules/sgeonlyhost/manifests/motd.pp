class sgeonlyhost::motd inherits userserver::motd {

	File["/etc/motd"]
	{
		source => "puppet:///sgeonlyhost/motd"
	}

}
