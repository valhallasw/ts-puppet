import "utils"

# Java
class software::java {
	case $operatingsystem {
                debian: {

			exec { 
				"agree-to-jdk-license":
					command => "/bin/echo -e sun-java6-jdk shared/accepted-sun-dlj-v1-1 select true | debconf-set-selections",
					unless => "debconf-get-selections | grep 'sun-java6-jdk.*shared/accepted-sun-dlj-v1-1.*true'",
					path => ["/bin", "/usr/bin"],
					require => Package["debconf-utils"];

				"java-alternative":
					command => "/usr/sbin/update-alternatives --set java /usr/lib/jvm/java-6-sun/jre/bin/java",
					onlyif => "/etc/alternatives/java -version 2>&1|/bin/grep -i 'openjdk'",
					require => Package["sun-java6-jdk"];
			}

                        package { 
				sun-java6-jdk:
                                        ensure => installed,
					require => [Exec["agree-to-jdk-license"], File["apt-unfree"]];
				ant: ;
				gcj: ;
				maven2: ;
				openjdk-6-jre-headless: ;

                        }
                }

		solaris: {
			# Java 6 Packages
			tspkg { 
				["j6rt", "j6rtx",
				"j6cfg",
				"j6dmo", "j6dmx",
				"j6dev", "j6dvx",
				"j6man", "j6jmp"]:
					prefix => "SUNW";
			}
		}

	}
} 
