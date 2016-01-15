class debian::ldap {
        file {
                "ldap.secret":
                        name => "/etc/ldap.secret", 
			owner => root, 
			group => root, 
			mode => 600,
                        source => "puppet:///modules/secret/ldap/ldap.secret";

               "libnss-ldap.conf": 
                        name => "/etc/libnss-ldap.conf",
                        owner => root, 
                        group => root,   
                        mode => 644,
                        source => "puppet:///base/ldap.conf";

        }
	
	package {
		libnss-ldap: 
			require => [File["ldap.secret"], File["libnss-ldap.conf"]];
	}

# The following service is the anker for every programm/service that needs a 
# working LDAP – especially if the program/service needs a user of the LDAP-
# system.

	service {
		ldap:
			name => nslcd,
			require => Package[libnss-ldap];
	}

}
