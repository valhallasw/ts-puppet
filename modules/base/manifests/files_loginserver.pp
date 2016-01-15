class base::files_loginserver inherits base::files {
	File["pam.conf"] { 
		source => "puppet:///base/pam.conf.login"
	}
}
