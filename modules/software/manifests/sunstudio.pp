import "utils"

# Sun Studio compiler and patches.
class software::sunstudio {
	exec { "install_studio":
		command => "/install/pkgs/studio_x86/SunStudio12u1-SunOS-x86-pkgs/SunStudio12u1-SunOS-x86-pkgs.sh --non-interactive-accept-license --nospacecheck",
		creates => "/opt/sunstudio12.1",
		require => Mount["/install"],
		cwd => "/",
		timeout => 3600
	}

	# Studio patches

	patch { 
		# Sun Studio 12 Update 1_x86: Patch for Fortran 95 8.4 Dynamic Libraries
		141853: rev => 01, require => Exec[install_studio];

		# Sun Studio 12 Update 1_x86: Patch for Fortran 95 8.4 Support Library
		141855: rev => 01, require => Exec[install_studio];

		# Sun Studio 12 Update 1_x86: Sun Compiler Common patch for x86 backend
		141858: rev => 05, require => Exec[install_studio];

		# Sun Studio 12 Update 1_x86: Patch for Fortran 95 8.4 Compiler
		141852: rev => 02,
			require => [
				Exec[install_studio],
				Patch[141853],
				Patch[141855],
				Patch[141858]
			];

		# Sun Studio 12 Update 1_x86: Patch for C Compiler
		142363: rev => 04,
			require => [
				Exec[install_studio],
				Patch[141858]
			];

		# Sun Studio 12.1_x86: Patch for Performance Analyzer Tools
		142368: rev => 01, require => Exec[install_studio];

		# Sun Studio 12 Update 1_x86: Patch for C++ Compiler
		128229: rev => 07,
			require => [
				Exec[install_studio], 
				Patch[141858]
			];
	}
	#
	# Sun Studio prior to 12u1 installed in /opt/SUNWspro, and a lot of
	# things expect to find it there.  Later versions changed the 
	# install path to /opt/sunstudio12.1 for no good reason, so we
	# create a symlink from the old location.
	file {
		"/opt/SUNWspro": 
			ensure => "sunstudio12.1", backup => false;
	}
}
