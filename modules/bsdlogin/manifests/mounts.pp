class bsdlogin::mounts inherits base::mounts {
        Mount["/home"] {
                device => "ha-nfs.esi:/global/home"
        }
}
