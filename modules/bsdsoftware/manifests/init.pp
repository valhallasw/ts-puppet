define yum() {
	package {
		"${name}":
			ensure => latest,
			provider => yum,
			require => [File["toolserver.repo"], Mount["/install"]];
	}
}
	
class bsdsoftware {
	file {
		"toolserver.repo":
			name => "/etc/yum/repos.d/toolserver.repo",
			owner => root, group => wheel, mode => 444,
			source => "puppet:///bsdsoftware/toolserver.repo";
	}

	include bsdsoftware::sudo
	include bsdsoftware::nss_ldapd
	include bsdsoftware::perl512

	yum {
		# Base packages that are required for the packaging system to function
		base: ;
		python26: ;
		python26-urlgrabber: ;
		python26-yum-metadata-parser: ;
		glib2: ;
		pcre: ;
		gettext: ;
		neon: ;
		libxml2: ;
		yum: ;
		readline: ;
		texinfo: ;
		sqlite: ;
		gdbm: ;
		libiconv: ;
		popt: ;
		beecrypt: ;
		rpm: ;

		# Other software that we want everywhere
		puppet: ;
		vim: ;
		zsh: ;
		bash: ;
		rsync: ;
		screen: ;
		pam_require: ;
		ksh93: ;
		gmake: ;
		subversion: ;
		coreutils: ;
		gtar: ;
		wget: ;
		arcconf: ;
	}

	rc_conf_local {
		"local_startup": value => "/usr/ts/rc.d";
	}

	# For Solaris compatibility
	file {
		"/opt":
			owner => root, group => wheel, mode => 644, ensure => directory;
		"/opt/ts":
			ensure => "/usr/ts";
	}
}
