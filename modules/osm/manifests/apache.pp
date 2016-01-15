class osm::apache {
	logadm {
                ["/var/log/http/access",
		 "/var/log/http/error"]:
                        ensure => present,
                        count => 4,
                        period => 1d,
                        ignore_missing => true,
			compress_count => 0,
                        post_command => "/opt/ts/apache/2.2/bin/apachectl restart";
        }
}
