class base::mounts_puppetmaster inherits esams::mounts {
	Mount["/install"] {
		device => "/aux1/install",
		fstype => "lofs",
		options => "-"
	}
}
