class base::screen {

case $operatingsystem {

	debian: {
		package {
			screen:
				require => File["screenrc"];
		}

		file {
			"screenrc":
				name => "/etc/screenrc",
                                owner => root, 
				group => root, 
				mode => 644,
				source => "puppet:///base/screenrc";
		}
	}

}
}