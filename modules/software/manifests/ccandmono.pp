class software::ccandmono {
        case $operatingsystem {
                debian: {
                        package {
				mono-complete: ;
                                #Than the modules/libs.
				"libboost-all-dev": ;
				"libboost-python-dev": ;
				"libdirectfb-dev": ;
				"libdmtx-dev": ;
				"libexpat1": ;
				"libexpat1-dev": ;
				"libjpeg62-dev": ;
				"libpam0g-dev": ;
				"libpng12-dev": ;
				"libsdl1.2-dev": ;
				"libtiff4-dev": ;
				"libxml2": ;
				"libxml2-dev": ;
				"libzbar-dev": ;
				"zlib1g-dev": ;				
                        }
                }
        }
}

#EOF
