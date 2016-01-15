define admin($uid, $comment = "", $shell = "/bin/bash") {
	case $operatingsystem {
               debian: {
                        user {
                                "$name":
                                        ensure => present,
                                        managehome => false,
                                        comment => "$comment",
                                        home => "/home/$name",  
                                        uid => $uid, gid => 100,
                                        shell => "$shell",
                                        password => "NP",
                                        require => [Package[bash], Group["wheel"], Group["users"]],
                                        groups => ["wheel", "users"];
                        }
                }

        	solaris: {
			user {
				"$name":
					ensure => present,
					managehome => false,
					comment => "$comment",
					home => "/home/$name",
					uid => $uid, gid => 1137,
					shell => "$shell",
					password => "NP",
					profiles => ["Primary Administrator"],
					auths => "solaris.*",
					require => Tspkg[bash];
			}
		}
	}
}
			
class base::users {
       case $operatingsystem {
		debian: {
                        user { 
                                # Change root's home directory to /root to prevent cluttering up /.
                                "root":
                                        ensure => present,      
                                        comment => "Super-User",
                                        home => "/root",
                                        gid => 0,
                                        shell => "/bin/bash",
                                        uid => 0,
                                        groups => ["root"];
			}

			group {
                        	"users": gid => 100;
                        }

			group {
                                "wheel": gid => 302;
                        }

			#Remove the installer-user from the Debian-installation.
			user {
				"installer":
					ensure => absent;
			}

			file {
				root-profile:
					name => "/root/.profile",
					owner => root,
					group => root,
					mode => 644,
					source => "puppet:///base/root-profile";
			}

		}
                solaris: {
			user { 
				# Change root's home directory to /root to prevent cluttering up /.
				"root":
					require => File["/root"],
					ensure => present,
					auths => "solaris.*",
					comment => "Super-User",
					home => "/root",
					gid => 0,
					managehome => false,
					profiles => ["All", "Basic Solaris User"],
					shell => "/sbin/sh",
					uid => 0,
					groups => ["other", "bin", "sys", "adm", "uucp", "mail", "tty", "lp", "nuucp", "daemon"];

				# System users
				"mysql":
				ensure => present,
					comment => "MySQL database user",
					home => "/",
					shell => "/bin/sh",
					uid => 1438, gid => 6016,
					managehome => false;
			}

			group {
				"mysql": gid => 6016;
				"admins": gid => 1137;
			}


			# Add the "Primary Administrator" profile to prof_attr, so pfexec works
			exec { 
				"add-padmin-prof":
					command => "echo 'Primary Administrator:::Can perform all administrative tasks:auths=solaris.*,solaris.grant;help=RtPriAdmin.html' >>/etc/security/prof_attr",
					unless => "grep '^Primary Administrator' /etc/security/prof_attr",
					path => "/usr/bin:/sbin:/usr/sbin";

				"add-padmin-exec":
					command => "echo 'Primary Administrator:suser:cmd:::*:uid=0;gid=0' >>/etc/security/exec_attr",
					unless => "grep '^Primary Administrator' /etc/security/exec_attr",
					path => "/usr/bin:/sbin:/usr/sbin";
			}
		}	
	}
	
       # Admin users
        admin {
                "rriver": uid => 500, comment => "River Tarnell", shell => "/bin/false";
                "rdaniel": uid => 502, comment => "Daniel Kinzler";
                "rdab": uid => 503, comment => "Daniel Baur";
                "ravar": uid => 1352, shell => "/bin/false"; 
                "rreedy": uid => 506, comment => "Sam Reed"; 
                "rsimetrical": uid => 504, comment => "Aryeh Gregor", shell => "/bin/false";
                "rtstarling": uid => 505, comment => "Tim Starling";
                "rwerdna": uid => 501, comment => "Andrew Garret";  
                "rnosy": uid => 507, comment => "Marlen Caemmerer"; 
        }

}
