class userserver::motd {
        file {
                "/etc/motd":
                        owner => "root",
                        group => "root",
                        mode => 444,
                        ensure => present,
			source => "puppet:///userserver/motd";
        }
}
