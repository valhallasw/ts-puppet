
case $operatingsystem {

        debian: {
		include internalserver::files
		include internalserver::apt
	}

	solaris: {

	import "base"
	import "*"

	class internalserver inherits base {
		include internalserver::files
	}
	}
}
