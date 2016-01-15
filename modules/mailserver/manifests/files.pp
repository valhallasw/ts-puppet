class mailserver::files {
        file {
                "/opt/local/bin/run_sa_update":
                        owner => root, group => root, mode => 555,
                        source => "puppet:///mailserver/run_sa_update";
	}
}
