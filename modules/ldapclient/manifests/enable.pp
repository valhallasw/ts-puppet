class ldapclient::enable inherits ldapclient::disable {
	case $operatingsystem {
		solaris: {
		        file { "ldap_client_cred":
        		        name => "/var/ldap/ldap_client_cred", owner => root, group => root, mode => 400,
	                	source => "puppet:///modules/secret/ldapclient/ldap_client_cred" }

		        file { "ldap_client_file":
		                name => "/var/ldap/ldap_client_file", owner => root, group => root, mode => 400,
		                source => "puppet:///base/ldap_client_file" }
	
			service["svc:/network/ldap/client:default"] {
		                ensure => running,
		                subscribe => File["ldap_client_cred", "ldap_client_file"],
				require => File["ldap_client_cred", "ldap_client_file"]
		        }
		}
		debian: {
			package { 
				libpam-ldapd:
					ensure => installed;
				nslcd:
					ensure => installed,
					require => Group[nslcd-group];
			}

			group {
				nslcd-group:
					name => "nslcd",
					gid => 207,
					ensure => present;
			}

			file {
				"nslcd.conf":
					name => "/etc/nslcd.conf",
					mode => 640,
					owner => root,
					group => nslcd,
					require => Group["nslcd-group"],
					source => "puppet:///ldapclient/nslcd.conf";
			}
			
		}
	}
}
