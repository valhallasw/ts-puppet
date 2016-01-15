define operator($uid, $comment = "Operator", $shell = "/bin/bash") {
	user {
        	"$name":
                	ensure => present,
                        managehome => true,
                        comment => "$comment",
                        home => "/home/$name",
                        uid => $uid, gid => 37,
                        shell => "$shell",
                        password => "NP",
                        require => [Package["bash"], Group["users"]],
                        groups => ["operator", "users"];

                }
}

class userserver::operators
{
	operator {
		"odab": uid => 601, comment => "Operator-account for dab.";
		"onosy": uid => 602, comment => "Operator-account for nosy.";
		"omerl": uid => 603, comment => "Operator-account for merl.";
		"oplatonides": uid => 604, comment => "Operator-account for platonides.";
		"odanny_b": uid => 605, comment => "Operator-account for danny_b.";
	}

	file {
		"/etc/sudoers.d/operators":
			owner => root,
			group => root,
			mode => 0440,
			require => Package["sudo-ldap"],
			source => "puppet:///userserver/sudo-operators";
	}
}
