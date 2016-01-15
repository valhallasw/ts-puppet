
class software::libmisc_user {
	# List here all liberies that need to install. Normaly libs are 
	# installed along with a program and should not listed here. 
	# However some "software" comes only as a libery.

	case $operatingsystem {

		debian: {
			package {
				"libboost1.42-dev": ;
				"libbsd-dev": ;
				"libcv2.1": ;
				"libdmtx0a": ;
				"liblua5.1-0": ;
				"libmysql++-dev": ;
				"libncurses5-dev": ;
				"lib32ncurses5": ;
				"libreadline-dev": ;
				"libzbar0": ;
				
                        }
		}
	}
}
