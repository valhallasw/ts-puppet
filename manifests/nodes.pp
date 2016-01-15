### Login servers

node 'wolfsbane.toolserver.org' {
	include esams
	include solaris
	include userserver
	include webserver
	include patches::s10u9

	munin-plugin {
		if_e1000g0: plugin => "if_";
	}
}

node 'ortelius.toolserver.org' {
	include esams
        include solaris
	include userserver
	include webserver
	include patches::s10u9

	munin-plugin {
		if_e1000g0: plugin => "if_";
	}
}

node 'willow.toolserver.org' {
	include esams
        include solaris
	include userserver
	include loginserver
	include patches::s10u9

	munin-plugin {
		if_bnx0: plugin => "if_";
	}
}

node 'yarrow.toolserver.org' {
	include esams
        include debian
	include dell1950
	include userserver
	include loginserver
}

node 'nightshade.toolserver.org' {
        include esams
        include debian
        include dell1950  
        include userserver
        include loginserver
}

node 'mayapple.toolserver.org' {
        include esams
        include debian
        include dell1950
        include userserver
	include sgeonlyhost

}

node 'clematis.toolserver.org' {
	include esams
        include solaris
	include userserver
	include patches::s10u9
	include submitserver
	include postfix::relay

	munin-plugin {
		if_bge0: plugin => "if_";
	}
}

node 'hawthorn.toolserver.org' {
	include esams
        include solaris
	include userserver
	include patches::s10u9
	include submitserver
	include postfix::relay

	munin-plugin {
		if_bge0: plugin => "if_";
	}
}

### Databases

node 'thyme.esi.toolserver.org' {
	include esams
        include solaris
	include internalserver
	include database
	include ipfilter::enable
	include patches::s10u9

	munin-plugin {
		if_e1000g0: plugin => "if_";
	}
}

node 'rosemary.esi.toolserver.org' {
	include esams
        include solaris
	include internalserver
	include database
	include ipfilter::enable
	include patches::s10u9

	munin-plugin {
		if_e1000g0: plugin => "if_";
	}
}

node 'hyacinth.esi.toolserver.org' {
	include esams
        include solaris
	include internalserver
	include database
	include ipfilter::enable
	include patches::s10u9

	munin-plugin {
		if_e1000g0: plugin => "if_";
	}
}

node 'yucca.esi.toolserver.org' {
        include esams
        include debian
	include nrpe
	include internalserver
	include xen::master
}

node 'sage.esi.toolserver.org' {
        include esams
        include debian
        include nrpe  
        include internalserver
        include xen::master   
}

node 'db-zone' {
	include esams
        include solaris
	include internalserver
	include database
}

node 'xen-db-domain' {
        include esams
        include debian
        include internalserver
        include database
}

node 'z-dat-s1-a.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s1-b.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s2-a.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s2-b.esi.toolserver.org' inherits 'xen-db-domain' {
	include database::withWikidata
	include database::expresstrain
}

node 'z-dat-s3-a.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s3-b.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s4-a.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s4-b.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s5-a.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s5-b.esi.toolserver.org' inherits 'xen-db-domain' {
	include database::withCommons
	include database::expresstrain
}

node 'z-dat-s6-a.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s6-b.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s7-a.esi.toolserver.org' inherits 'db-zone' {
}

node 'z-dat-s7-b.esi.toolserver.org' inherits 'db-zone' {
}

node 'cassia.esi.toolserver.org' {
	include esams
        include solaris
	include internalserver
	include database
	include ipfilter::enable
	include patches::s10u9

	munin-plugin {
		if_e1000g0: plugin => "if_";
	}
}

node 'daphne.toolserver.org' {
	include esams
        include solaris
	include base
	include database
	include ipfilter::enable

	munin-plugin {
		if_e1000g2: plugin => "if_";
	}
}

node 'adenia.esi.toolserver.org' {
	include esams
        include solaris
	include base
	include database
	include ipfilter::enable
	include internalserver

	munin-plugin {
		if_e1000g0: plugin => "if_";
	}
}

# OSM
node 'ptolemy.esi.toolserver.org' {
	include esams
        include solaris
	include base
	include software::apache
	include software::osm
	include software::devel
        include software::misc_user
        include software::gnu
	include internalserver
	include ipfilter::enable
	include patches::s10u9
	include osm

        File <| name == "/etc/pam_list.conf" |> {
                source => "puppet:///osm/pam_list.conf.osm"
        }

#	munin-plugin {
#		if_e1000g0: plugin => "if_";
#	}
}

# Miscellaneous
node 'amaranth.toolserver.org' {
	include pmtpa
	include base
        include solaris
        include software::misc_std
        include software::misc_user
        include software::perl5
        include software::perl512
        include software::perl514
        include software::python26
        include software::python26_modules
        include software::python27
        include software::python27_modules
        include software::python31
        include software::python31_modules
        include software::python32
        include software::python32_modules
        include software::ruby
        include software::mgmt
        include software::php53
        include software::gnu
        include software::tcl
        include software::osm
        include software::devel
        include software::apache
	include ipfilter::enable

	# JIRA -> IRC bot
	mailalias {
		"jirairc": recipient => "| /opt/local/bin/jira_irc.pl", notify => Exec[postfix-newaliases];
	}
}

node 'hemlock.toolserver.org' {
	include esams
	include base
        include solaris
	include base::mounts_puppetmaster
	include ipfilter::enable
	include patches::s10u9
	include software::mgmt
	include software::devel
	# hemlock is the build system
        include software::python26_modules
        include software::python27_modules
        include software::python31_modules
        include software::python32_modules
        include software::misc_user
        include software::php53
        include software::gnu
        include software::tcl
        include software::osm
        include software::devel
	include munin::master

	# hemlock is the loghost
	File <| name == "/etc/syslog.conf" |> {
		source => "puppet:///base/syslog.conf.loghost"
	}

	File <| name == "/etc/ntp.conf" |> {
		source => "puppet:///ntp/ntp.conf.cluster"
	}

	munin-plugin {
		if_e1000g0: plugin => "if_";
	}
}

node 'cluster' {
#        include esams  
        include solaris
	include internalserver
	include ipfilter::enable
	include base::mounts_cluster
	include base::files_cluster
	include base::svnserver
	include mailserver
	include clusterserver
	include software::mgmt
	include software::devel
	include software::apache
	include software::php53
	# for irclib at least
#	include software::python26_modules
#	include software::python27_modules
	include munin::pdns

	tspkg {
		python26-supybot: root => true, ensure => absent;
		python26-supybot-bin: ensure => absent;

		python27-supybot: root => true, require => Tspkg[python26-supybot];
		python27-supybot-bin: require => Tspkg[python26-supybot-bin];
	}

	File <| name == "/etc/ntp.conf" |> {
		source => "puppet:///ntp/ntp.conf.cluster"
	}
}

node 'turnera.esi.toolserver.org' inherits cluster {
}

node 'damiana.esi.toolserver.org' inherits cluster {
}
