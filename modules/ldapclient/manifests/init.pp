class ldapclient {
	service { "svc:/network/ldap/client:default":
		ensure => stopped
	}
}
