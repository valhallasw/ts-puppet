class base::hostkeys {
	File {
		owner => root, group => root
	}

        $sshprefix = $operatingsystem ? {
                debian => "/etc/ssh",
                solaris => "/etc/opt/ts/ssh"
        }

        $sshrequire = $operatingsystem ? {
                debian => Package[ssh],
                solaris => Tspkg[openssh]
        }

case $operatingsystem {
solaris: {
	file {
                "ssh_host_ecdsa_key":
                        require => $sshrequire,
                        name => "$sshprefix/ssh_host_ecdsa_key",
                        mode => 400,
                        source => "puppet:///modules/secret/base/keys/$hostname/ssh_host_ecdsa_key";

                "ssh_host_ecdsa_key.pub":
                        require => $sshrequire,
                        name => "$sshprefix/ssh_host_ecdsa_key.pub",
                        mode => 444,
                        source => "puppet:///modules/secret/base/keys/$hostname/ssh_host_ecdsa_key.pub";
	}
}
}
		


	# Put the right host keys in place for all systems
	file { 
		"ssh_host_dsa_key":
			require => $sshrequire,
			name => "$sshprefix/ssh_host_dsa_key",
			mode => 400,
			source => "puppet:///modules/secret/base/keys/$hostname/ssh_host_dsa_key";

		"ssh_host_rsa_key":
			require => $sshrequire,
			name => "$sshprefix/ssh_host_rsa_key",
			mode => 400,
			source => "puppet:///modules/secret/base/keys/$hostname/ssh_host_rsa_key";



		"ssh_host_dsa_key.pub":
			require => $sshrequire,
			name => "$sshprefix/ssh_host_dsa_key.pub",
			mode => 444,
			source => "puppet:///modules/secret/base/keys/$hostname/ssh_host_dsa_key.pub";

		"ssh_host_rsa_key.pub":
			require => $sshrequire,
			name => "$sshprefix/ssh_host_rsa_key.pub",
			mode => 444,
			source => "puppet:///modules/secret/base/keys/$hostname/ssh_host_rsa_key.pub";

		"ssh_known_hosts":
			require => $sshrequire,
			name => "$sshprefix/ssh_known_hosts",
			mode => 444,
			source => "puppet:///base/ssh_known_hosts";
	}
}
