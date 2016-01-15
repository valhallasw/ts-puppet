import "*"

class esams {
	include esams::mounts
	include esams::files
	include ldapclient::enable

        case $operatingsystem {
		solaris:
		{
	
		service {
			"svc:/network/rwhod:default":
	                        require => File["/var/svc/manifest/network/rwhod.xml"],
	                        ensure => running,
	                        manifest => "/var/svc/manifest/network/rwhod.xml" ;
	
	                # All services needed for NFS client
	                ["svc:/network/nfs/client:default",
	                 "svc:/network/nfs/nlockmgr",
	                 "svc:/network/rpc/bind"]:
	                        ensure => running;
		}
		}
	}
}
