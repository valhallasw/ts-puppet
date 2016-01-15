import "utils"

# Python 3.1 + standard modules.
class software::python32 {
        tspkg { 
		python32: ;
	}

	file {
		"/usr/bin/python3.2":	ensure => "/opt/ts/python/3.2/bin/python";
	}
}

# Python modules only needed on login servers
class software::python32_modules {
	tspkg {
		python32-cython: ;
		python32-oursql: ;
		python32-psycopg2: ;
	}
}
