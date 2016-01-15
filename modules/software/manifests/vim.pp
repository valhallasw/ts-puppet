class software::vim {
	case $operatingsystem {
		debian: {
			package {
				vim: ;

				vim-scripts: 
					require => Package[vim];
			}

			file {

				# Because we use the .local-file we require
				# the package (which will create the dir for us).
				vimrc:
					name => "/etc/vim/vimrc.local",
                                        require => Package["vim"],
                                        owner => root, 
					group => root, 
					mode => 644,
                                        source => "puppet:///software/vimrc.local";
	
			}

		}
	}
}


