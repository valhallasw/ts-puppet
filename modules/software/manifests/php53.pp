import "utils"

# PHP 5.3
class software::php53 {
	include software::postgres90

	tspkg {	
		libmcrypt4: dev => true, ensure => absent;
		libmcrypt: requires => Tspkg[libmcrypt4];
		php53: root => true;
		php53-apc: ;
		php53-imagick: ;
		php53-yaz: ;
		php53-zip: ;
		php53-pmd: ;
		php53-pdepend: ;
		php53-xdebug: ;
		php53-perusersessionsavepath: ;
		php53-phpdocumentor: ;
		php53-Net-URL2: ;
		php53-HTTP-Request2: ;
		phc: ;
	}

	file {
		"/usr/bin/php5.3":	ensure => "/opt/ts/php/5.3/bin/php";
		"/usr/bin/php":		ensure => "php5.3";

		"/etc/opt/ts/php":
			require => File["/etc/opt/ts"],
			owner => root, group => sys, mode => 755, ensure => directory;

		"/etc/opt/ts/php/5.3":
			require => File["/etc/opt/ts/php"],
			owner => root, group => sys, mode => 755, ensure => directory;

		"/etc/opt/ts/php/5.3/php.ini": 
			require => File["/etc/opt/ts/php/5.3"],
			owner => root, group => root, mode => 444,
			source => "puppet:///base/php.ini";
	}
}
