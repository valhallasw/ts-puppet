import "utils"

# Tcl programming language
class software::tcl {
        case $operatingsystem {
                debian: {
                        package {
                                #The main-packages at the top.
                                "tcl8.5": ;
                                #Than the modules.
				mysqltcl: ;
				tclcurl: ;
				tcllib: ;
				tcl-trf: ;
				tcl-tls: ;
				tdom: ;
				tclthread: ;
			}
		}
                solaris: {
			tspkg { 
				libtcl85: dev => true, ensure => absent;
				tclsh85: ensure => absent;
				tcl85: require => [Tspkg[tclsh85], Tspkg[libtcl85]];
				tcl85-graphviz: ;
				mysqltcl85: ;
				tcl85-cgitcl: ;
				tcl85-fcgitcl: ;
				tcl85-xmlgen: ;
				tcl85-tcllib: ;
				tcl85-tclcurl: ;
				tcl85-tls: ;
				tcl85-zlib: ;
				tcl85-trf: ;
				tcl85-tdom: ;
			}
		}
	}
}
