class osm::mounts inherits esams::mounts {
        Mount["/home"] {
                device => "ha-nfs.esi:/global/home"
        }
}
