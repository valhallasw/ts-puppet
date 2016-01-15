class base::mounts_cluster inherits esams::mounts {
	Mount["/home"] {
		ensure => absent
	}

	Mount["/shared"] {
		ensure => absent
	}

	File["/home"] {
		ensure => "/global/home"
	}

	File["/shared"] {
		ensure => "/global/misc/shared"
	}
}
