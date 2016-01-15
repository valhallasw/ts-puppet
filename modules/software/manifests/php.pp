class software::php {
        case $operatingsystem {
                debian: {
                        package {
				#The main-packages at the top.
				#Meta-package which installs apache.
                                "php5":
					ensure => absent;
				"php5-cli": ;
				#Than the modules.
				"php5-curl": ;
				"php5-mysql": ;
				"php5-pgsql": ;
				"php5-sqlite": ;
                        }
                }
	}
}
