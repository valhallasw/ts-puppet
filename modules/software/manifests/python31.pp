import "utils"

# Python 3.1 + standard modules.
class software::python31 {
        tspkg { 
		python31: ;
	}

	file {
		"/usr/bin/python3.1":	ensure => "/opt/ts/python/3.1/bin/python";
		"/usr/bin/python3":	ensure => "/opt/ts/python/3.1/bin/python";
	}
}

# Python modules only needed on login servers
class software::python31_modules {
	tspkg {
		python31-cython: ;
		python31-oursql: ;
		python31-psycopg2: ;
	}
}
