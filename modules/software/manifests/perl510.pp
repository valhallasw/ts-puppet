import "utils"

# Perl 5.10, and our standard list of modules.
class software::perl510 {
	# Perl modules - 5.10
        tspkg { [perl510,
		perl510-Crypt-DES,
		perl510-Crypt-SSLeay,
        	perl510-Curses,
        	perl510-DBD-SQLite,
        	perl510-DBD-mysql,
        	perl510-DateTime,
        	perl510-Digest-SHA1,
        	perl510-Event,
        	perl510-FCGI,
        	perl510-GD,
        	perl510-HTML-Parser,
        	perl510-IO-Tty,
        	perl510-IPC-ShareLite,
        	perl510-List-MoreUtils,
        	perl510-Net-DNS,
        	perl510-Params-Validate,
        	perl510-Socket6,
        	perl510-Sun-Solaris-Exacct,
        	perl510-Term-ReadKey,
        	perl510-XML-Parser,
		perl510-Mouse,
		perl510-Sub-Name,
		perl510-Params-Util,
		perl510-Class-MOP,
		perl510-Moose,
		perl510-D-GlobalDestruction,
		perl510-DB-File,
		perl510-Net-SSLeay,
		perl510-Encode-Detect,
		perl510-Crypt-OpenSSL-Random,
		perl510-Crypt-OpenSSL-RSA,
		perl510-BerkeleyDB,
		perl510-Clone,
		perl510-Text-Unaccent,
		perl510-YAML-LibYAML,
		perl510-CSS-Minifier-XS,
		perl510-JavaScript-Minifier-XS,
		perl510-DBI,
		perl510-graphviz
	]: ensure => absent;
	
		# /opt/ts/bin/cronjob used to be in TScronjob, but now
		# it's in TSperl510-App-Cronjob.
		perl510-App-Cronjob: require => Tspkg[cronjob], ensure => absent;
		cronjob: ensure => absent;
	}
		
	# Perl modules that should not be installed, but might exist on
	# old systems.
	tspkg {
		[ perl510-Compress-Raw-Zlib,
		perl510-Digest-SHA,
		perl510-Algorithm-Diff,
		perl510-Hash-Merge,
		perl510-Net-IP,
		perl510-Net-Ident,
		perl510-URI,
		perl510-HTML-Tagset,
		perl510-LWP,
		perl510-POE,
		perl510-XML-Simple,
		perl510-HTTP-Server-Simple,
		perl510-WWW-Mechanize,
		perl510-UNIVERSAL-moniker,
		perl510-Try-Tiny,
		perl510-TimeDate,
		perl510-Tie-Restore,
		perl510-Text-Template,
		perl510-Text-Markdown,
		perl510-Text-Diff,
		perl510-Task-Weaken,
		perl510-Sys-Hostname-Long,
		perl510-Sub-Install,
		perl510-Data-OptList,
		perl510-Sub-Exporter,
		perl510-String-Flogger,
		perl510-Scope-Guard,
		perl510-POE-Filter-IRCD,
        	perl510-POE-C-Pluggable,
        	perl510-POE-C-IRC,
		perl510-Net-Server,
        	perl510-Digest-HMAC,
        	perl510-Net-SNMP,
        	perl510-Net-Netmask,
		perl510-Net-DNSBLLookup,
		perl510-MRO-Compat,
		perl510-Log-Dispatchouli,
		perl510-Log-Dispatch,
		perl510-Log-Dispatch-Array,
		perl510-Log-Log4perl,
		perl510-MailTools,
		perl510-IPC-Run3,
		perl510-Ima-DBI,
		perl510-IO-Multiplex,
		perl510-IO-Socket-SSL,
        	perl510-HTML-Tree,
		perl510-IO-stringy,
		perl510-JSON,
        	perl510-Error,
        	perl510-HTML-Template,
		perl510-GetoptLongDescriptive,
		perl510-Email-Date-Format,
		perl510-Email-Simple,
		perl510-Email-Sender,
		perl510-Email-Address,
        	perl510-IO-Socket-INET6,
        	perl510-DateTime-TimeZone,
		perl510-Mail-DKIM,
		perl510-DBIx-ContextualFetch,
		perl510-Class-DBI,
        	perl510-DT-Format-Duration,
		perl510-Email-Abstract,
        	perl510-Cache-Cache,
        	perl510-DateTime-Locale,
		perl510-File-Slurp,
        	perl510-CGI-Cache,
		perl510-Class-Accessor,
		perl510-HTML-Packer,
		perl510-Class-Data-Inheritable,
		perl510-Class-Trigger,
		perl510-POE-Test-Loops]: ensure => absent;
	}

	# Solaris ships its own Perl, but we don't like it.  Make sure
	# /usr/bin/perl points to our version.
	file {
		"/usr/bin/perl5.10":	ensure => absent;
	}
}
