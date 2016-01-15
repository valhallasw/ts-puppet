class base::files_cluster inherits base::files {
	File <| name == "ntp.conf" |> {
		source => "puppet:///base/ntp.conf.cluster"
	}
}
