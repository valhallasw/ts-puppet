class software::lua {
        case $operatingsystem {
                debian: {
                        package {
				#The main-packages at the top.
				"lua5.1": ;
				#Than the modules.
				"liblua5.1-lpeg2": ;
				"liblua5.1-socket2": ;
				"liblua5.1-sql-mysql-2": ;
				"liblua5.1-zip0": ;
                        }
                }
	}
}
