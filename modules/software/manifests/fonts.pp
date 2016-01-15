import "utils"

# Various fonts
class software::fonts {
	case $operatingsystem {
		debian: {
			package {
				ttf-dejavu: ;
				ttf-unifont: ;
			}	
		}

		solaris: {
			tspkg {
				corefonts: ;
				dejavu-fonts: root => true;
				android-fonts: ;
				unifont: ;
			}
		}
	}
}
