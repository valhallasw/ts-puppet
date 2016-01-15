import "utils"

class software::apache {
	# Apache
	tspkg { 
		apache22: root => true;
		apache22-devel: ;
	}
}
