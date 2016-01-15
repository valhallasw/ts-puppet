class bsdsoftware::perl512 {
	yum {
		perl512: ;
		perl512-Digest-SHA1: ;
		perl512-IPC-ShareLite: ;
	}

        file {
                "/usr/bin/perl5.12":    ensure => "/usr/ts/perl/5.12/bin/perl";
                "/usr/bin/perl":        ensure => "perl5.12";
        }
}
