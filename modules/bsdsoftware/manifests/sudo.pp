class bsdsoftware::sudo {
	file {
		"/etc/ts/sudo/ldap.conf":
			owner => root, group => wheel, mode => 444,
			source => "puppet:///bsdsoftware/sudo_ldap.conf",
			require => Yum[sudo];
		"/etc/pam.d/sudo":
			owner => root, group => wheel, mode => 444,
			source => "puppet:///bsdsoftware/pam_sudo",
			require => Yum[sudo];
	}

	yum {
		sudo: ;
	}
}
