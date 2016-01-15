import "utils"

# Python 2.7 + standard modules.
class software::python27 {
        tspkg { 
		python27: ;
        	python27-setuptools: ;
	}

	file {
		"/usr/bin/python2.7":	ensure => "/opt/ts/python/2.7/bin/python";
		"/usr/bin/python":	ensure => "python2.7";
	}
}

# Python modules only needed on login servers
class software::python27_modules {
	tspkg {
        	python27-flickrapi: ;
        	python27-flup: ;
        	python27-cheetah: ;
        	python27-beaker: ;
        	python27-sqlalchemy: ;
        	python27-irclib: ;
        	python27-mysql: ;
        	python27-pil: ;
        	python27-pydot: ;
        	python27-pyparsing: ;
        	python27-simplejson: ;
		python27-lxml: ;
		python27-twisted: ;
		python27-httplib2: ;
		python27-sphinx: ;
		python27-oursql: ;
		python27-zope-interface: ;
		python27-cython: ;
		python27-cssutils: ;
		python27-numpy: ;
		python27-matplotlib: ;
		python27-pyoai: ;
		python27-mako: ;
		python27-svn: ;
		python27-dateutil: ;
		python27-genshi: ;
		python27-pyexiv2: ;
		python27-pyxml: ;
		python27-beautifulsoup: ;
		python27-virtualenv: ;
		python27-ipython: ;
		python27-pysvn: ;
		python27-jinja: ;
		python27-psycopg2: ;
		python27-pyquery: ;
		python27-guppy: ;

		scons: ;
	}
}
