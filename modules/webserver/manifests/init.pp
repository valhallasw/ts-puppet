class webserver {

case $operatingsystem {

	debian: {
		include webserver::mounts
		include webserver::apache
		include webserver::tomcat
		include webserver::motd

	}

	solaris: {
		include webserver::mounts
		include webserver::zws
		include munin::zws
		include tomcat
		include webserver::motd
	}
}
}
