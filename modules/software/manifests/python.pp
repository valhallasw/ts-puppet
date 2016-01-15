class software::python {
        case $operatingsystem {
                debian: {
                        package {
				#The main-packages at the top.
                                "python2.6": ;
				"python3.1": ;
				#Than the modules.
				ipython: ;
				python-bottle: ;
				python-cheetah: ;
				python-dateutil: ;
				python-imaging: ;
				python-flup: ;
				python-httplib2: ;
				python-irclib: ;
				python-levenshtein: ;
				python-lua: ;
				python-magic: ;
				python-matplotlib: ;
				python-mysqldb: ;
				python-numpy: ;
				python-opencv: ;
				python-psycopg2: ;
				python-pyinotify: ;
				python-pyexiv2: ;
				python-rsvg: ;
				python-scipy: ;
				python-svn: ;
				python-twisted-words: ;
				python-zbar: ;
                        }
                }
	}
}
