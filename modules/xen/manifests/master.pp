class xen::master {

	package {
		"linux-image-xen-amd64":
			require => File["apt-sources"];
		"xen-tools": ;
		"xen-utils-4.0": ;
	}

	exec {
		"xen-master-comm1":
			path    => ["/usr/bin", "/usr/sbin"],
			command => "dpkg-divert --divert /etc/grub.d/08_linux_xen --rename /etc/grub.d/20_linux_xen",
			notify => Exec["xen-master-comm2"],
			creates => "/etc/grub.d/08_linux_xen";
		
		"xen-master-comm2":
			command => "update-grub",
			path    => ["/usr/bin", "/usr/sbin"],
			refreshonly => true; 
	}

	file {
		"/etc/xen-tools/xen-tools.conf":
                	name => "/etc/xen-tools/xen-tools.conf",
                        owner => root,
                        group => root,
			require => Package["xen-tools"],
			source => "puppet:///xen/master/xen-tools.conf";

                "/etc/xen/xend-config.sxp":
                        name => "/etc/xen/xend-config.sxp",
                        owner => root,
                        group => root,
                        require => Package["xen-utils-4.0"],
                        source => "puppet:///xen/master/xend-config.sxp";

	}


	# Nagios checks.
	file {
		"/usr/local/lib/nagios/plugins/check-xen-vm.sh":
			name => "/usr/local/lib/nagios/plugins/check-xen-vm.sh",
                        owner => root,
                        group => root,
			mode => 755,
			require => File["nrpe-local-plugins-dir"],
                        source => "puppet:///xen/master/nagios_check-vm.sh";

		"/etc/nagios/nrpe.d/xen.cfg":
			name => "/etc/nagios/nrpe.d/xen.cfg",
                        owner => root,
                        group => root,
                        mode => 644,
                        require => [File["nrpe-conf-dir"], File["/usr/local/lib/nagios/plugins/check-xen-vm.sh"]],
			notify => Service[nrpe],
                        source => "puppet:///xen/master/nagios-xen.cfg.$hostname";


	}

	include xen::munin

}