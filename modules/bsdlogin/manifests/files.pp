class bsdlogin::files inherits freebsd::files {
	# Allow users to log in
	File["/etc/pam.d/sshd"] {
		source => "puppet:///bsdlogin/pam_sshd"
	}

	File["/etc/pam.d/system"] {
		source => "puppet:///bsdlogin/pam_system"
	}
}
