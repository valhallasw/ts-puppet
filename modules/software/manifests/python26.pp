import "utils"

# Python 2.6 + standard modules.
class software::python26 {
        tspkg { 
		python26: ensure => absent;
        	python26-setuptools: ensure => absent;
	}

	file {
		"/usr/bin/python2.6":	ensure => absent;
	}
}

# Python modules only needed on login servers
class software::python26_modules {
	tspkg {
		# Python 2.6 removed 2010-01-03
        	python26-flickrapi: ensure => absent;
        	python26-flup: ensure => absent;
        	python26-cheetah: ensure => absent;
        	python26-beaker: ensure => absent;
        	python26-sqlalchemy: ensure => absent;
        	python26-irclib: ensure => absent;
        	python26-mysql: ensure => absent;
        	python26-pil: ensure => absent;
        	python26-pydot: ensure => absent;
        	python26-pyparsing: ensure => absent;
        	python26-simplejson: ensure => absent;
        	python26-xcbgen: ensure => absent;
		python26-lxml: ensure => absent;
		python26-twisted: ensure => absent;
		python26-httplib2: ensure => absent;
		python26-sphinx: ensure => absent;
		python26-genshi: ensure => absent;
		python26-oursql: ensure => absent;
		python26-zope-interface: ensure => absent;
		python26-cython: ensure => absent;
		python26-cssutils: ensure => absent;
		python26-numpy: ensure => absent;
		python26-dateutil: ensure => absent;
		python26-matplotlib: ensure => absent;
		python26-pyoai: ensure => absent;
		python26-mako: ensure => absent ;
	}
}
