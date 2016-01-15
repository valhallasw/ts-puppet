class debian {
	
	include debian::ldap
	include debian::apt
	include debian::ips
	include debian::nagios
	include debian::locale
	include debian::syslog
	include debian::cgroup
	include debian::man
}
