class base::files {
	# Various files that should be installed on all nodes.

	File {
		owner => root, group => root, mode => 444
	}

        $sshprefix = $operatingsystem ? {
                debian => "/etc/ssh",
                solaris => "/etc/opt/ts/ssh"
        }

	$sshpackage = $operatingsystem ? {
                debian => Package[ssh],
                solaris => Tspkg[openssh]
        }

	file {
		"ssh_shosts.equiv": 
			name => $operatingsystem ? {
		                debian => "$sshprefix/shosts.equiv",
		                solaris => "$sshprefix/ssh_shosts.equiv"
		        },
			require => $sshpackage,
			source => "puppet:///base/shosts.equiv";

		"ssh_config":
			require => $sshpackage,
			name => "$sshprefix/ssh_config",
			source => "puppet:///base/ssh_config.$operatingsystem";

		"sshd_config":
			require => $sshpackage,
			name => "$sshprefix/sshd_config",
			source => "puppet:///base/sshd_config.$operatingsystem";

		"/etc/nsswitch.conf": 
			source => "puppet:///base/nsswitch.conf.$operatingsystem";

		# root's files
		"/root":
			mode => 700, ensure => directory;

		"/root/.ssh": 
			require => File["/root"],
			mode => 700, ensure => directory;

		"/root/.ssh/id_rsa": 
			require => File["/root/.ssh"],
			mode => 400, source => "puppet:///modules/secret/base/root/.ssh/id_rsa";

		"/root/.ssh/id_rsa.pub": 
			require => File["/root/.ssh"],
			mode => 400, source => "puppet:///modules/secret/base/root/.ssh/id_rsa.pub";

		"/root/.my.cnf":
			require => File["/root"],
			mode => 400, source => "puppet:///modules/secret/base/root/my.cnf";
	}
}
