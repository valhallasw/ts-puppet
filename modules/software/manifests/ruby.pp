import "utils"

class software::ruby {
	case $operatingsystem {
                debian: {
                        package { 
				"ruby1.8": ;
                        }
                }

		solaris: {
			# Ruby + modules - 1.8
			tspkg {
				ruby18: ;
				ruby18-facter: ;
				ruby18-rake: ;
				ruby18-proj4rb: ;
				ruby18-rubygems: ;
				ruby18-libxml: ;
			}

			file {
				"/usr/bin/ruby1.8": ensure => "/opt/ts/ruby/1.8/bin/ruby";
			}

			# Ruby + modules - 1.9
			tspkg {
				ruby19: ;
			}

			file {
				"/usr/bin/ruby1.9": ensure => "/opt/ts/ruby/1.9/bin/ruby";
			}

			# Ruby 1.8 is the default for now
			file {
				"/usr/bin/ruby": ensure => "ruby1.8";
			}
		}
	}
}
