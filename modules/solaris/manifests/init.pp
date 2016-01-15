class solaris {
	logadm {
		["/var/adm/messages",
		"/var/log/syslog",
		"/var/log/maillog",
		"/var/log/authlog",
		"/var/log/userlog"]:
			ensure => present,
			count => 8,
			period => 1d,
			ignore_missing => true,
			post_command => "kill -HUP `cat /var/run/syslog.pid`";
	}

	mount {

                #Remove old mount for /sge62.
                "/sge62":
                        atboot => yes,
                        device => "ha-nfs.esi:/global/misc/sge62",
                        fstype => "nfs",
                        options => "proto=udp,vers=3",
                        ensure => absent;

        }


	include files
	include services

	# Software that absolutely every server should have
	include software::misc_std
	include software::perl5
	include software::perl510
	include software::perl512
	include software::perl514
	include software::java
	#include software::sunstudio
	include software::python26
	include software::python27
	include software::python31
	include software::python32
	include software::ruby
	include software::mgmt
	include ipfilter::disable
	include software::devel
	include software::gnu
	include cronie
}
