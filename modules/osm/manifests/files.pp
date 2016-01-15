class osm::files {
	File <| name == "/etc/pam_list.conf" |> {
                source => "puppet:///osm/pam_list.conf.osm"
	}
}
