include scripts

define script {
	case $operatingsystem {
		debian: {
                        file { 
                                "/usr/local/bin/$name":
                                require => File["/usr/local/bin"],
                                owner => root, 
				group => root, 
				mode => 755,
                                ensure => present,
                                source => "puppet:///scripts/$name"
                        }
		}
		solaris: {
			file { 
				"/opt/local/bin/$name":
				require => File["/opt/local/bin"],
				owner => root, group => root, mode => 755,
				ensure => present,
				source => "puppet:///scripts/$name"
			}
		}
	}
}

class userserver::scripts {

	# /opt/local scripts that a login server should have.

	case $operatingsystem {
		debian: {
			script {
				become: ;
				cronsub: ;
				sql: ;
			}
		}

	        solaris: {
			script {
				become: ;
				cronsub: require => Script[cronex];
				cronex: ;
				sql: ;
				ttyallow: ;
				setenv: ;
			}
		}
	}
}
