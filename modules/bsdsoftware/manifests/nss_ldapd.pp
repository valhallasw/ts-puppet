class bsdsoftware::nss_ldapd {
	yum {
		nss-pam-ldapd: ;
	}

	file {
		"nslcd.conf":
			name => "/etc/ts/nslcd.conf",
			owner => root, group => wheel, mode => 400,
			source => "puppet:///bsdsoftware/nslcd.conf";
	}

	service {
		"nslcd":
			ensure => running,
			enable => true,
			path => "/usr/ts/rc.d",
			require => Yum["nss-pam-ldapd"];
	}
}
