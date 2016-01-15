include scripts

define script {
	file { "/opt/local/bin/$name":
		require => File["/opt/local/bin"],
		owner => root, group => root, mode => 755,
		ensure => present,
		source => "puppet:///scripts/$name"
	}
}

class scripts::loginserver inherits scripts {

	# /opt/local scripts that a login server should have.

	script {
		become: ;
		cronsub: ;
		sql: ;
		ttyallow: ;
		setenv: ;
	}
}
