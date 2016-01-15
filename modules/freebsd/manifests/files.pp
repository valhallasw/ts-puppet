class freebsd::files {
	file {
		"/etc/ts/ldap.secret":
			owner => root, group => wheel, mode => 400,
			source => "puppet:///modules/secret/ldap/ldap.secret";

		"/etc/profile":
			owner => root, group => wheel, mode => 444,
			source => "puppet:///freebsd/profile";

		"/etc/bash.bashrc":
			owner => root, group => wheel, mode => 444,
			source => "puppet:///freebsd/bash.bashrc";

		"/etc/pam.d/sshd":
			owner => root, group => wheel, mode => 444,
			source => "puppet:///freebsd/pam_sshd";

		"/etc/pam.d/system":
			owner => root, group => wheel, mode => 444,
			source => "puppet:///freebsd/pam_system";
	}

        # login.conf
        file {
                "/etc/login.conf":
                        owner => root, group => wheel, mode => 444,
			content => template("freebsd/login.conf.erb");
                        #source => "puppet:///base/login.conf";
        }

        exec {
                "/usr/bin/cap_mkdb /etc/login.conf":
                        refreshonly => true,
                        subscribe => File["/etc/login.conf"];
        }
}
