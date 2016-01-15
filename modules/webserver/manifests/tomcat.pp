class webserver::tomcat {

case $operatingsystem {

       	debian: {

               user {
                        tomcat:
                                name => "tomcat",
                                require => Group["tomcat"],
                                uid => 110,
                                gid => "tomcat",
				groups => ["tomcat6","webservd"],
                                home => "/usr/share/tomcat6",
                                comment => "tomcat-user";
                }
	

                group {
                        tomcat:
                                name => "tomcat",
                                gid => 1100;

			#Debian creates this group by default.  We do not use
			#it, but to prevent that it uses a already taken 
			#gid, we create it here.
                        tomcat6:
                                name => "tomcat6",
                                gid => 214;
                }


		package {
			tomcat:
				name => tomcat6,
				require =>[Service["ldap"],File["/www","tomcat-default"],User["tomcat"]];

			libmysql-java: ;
		}

		service {
			tomcat:
				name => "tomcat6",
				ensure => running,
				require => [Package["tomcat"],File["tomcat-default"]];
		}

                file {
			tomcat-dir:
				name => "/etc/tomcat6/",
				ensure => directory,
                                owner => root,  
                                group => tomcat,
				recurse => true,
				require => Group["tomcat"];

                        tomcat-server-xml:
                                name => "/etc/tomcat6/server.xml",
                                owner => root,
                                group => tomcat,
                                mode => 644,
                                require => [Package["tomcat"],Group["tomcat"]],
                                notify => Service["tomcat"],
                                source => "puppet:///webserver/tomcat/server.xml";

                        tomcat-default:
                                name => "/etc/default/tomcat6",
                                owner => root,
                                group => root,
                                mode => 644,
                                notify => Service["tomcat"],
                                source => "puppet:///webserver/tomcat/default-tomcat";

			
                        tomcat-var-log-tomcat:
                                name => "/var/log/tomcat",
                                ensure => directory,
                                owner => tomcat,  
                                group => tomcat,
				mode => 755,
                                require => Group["tomcat"];

			# For old .war-files.
			tomcat-usr-log:
				name => "/usr/share/tomcat6/logs",
				ensure => "link",
				target => "/var/log/tomcat",
				require => File["tomcat-var-log-tomcat"];
		}

               exec {
                        "tomcat-link-mysql-jar":
                                command => "/bin/ls -s /usr/share/java/mysql.jar /usr/share/tomcat6/lib/",
				require => Package["libmysql-java"],
                                refreshonly => true,  
                                notify => Service["tomcat"];
                }

	}

}
}