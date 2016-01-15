import "utils"

# Software which is installed on management hosts
class software::mgmt {
	tspkg {
		ldapvi: ;
		quotatool: ;
	}
}
