import "utils"

# Perl 5.12, and our standard list of modules.
class software::perl512 {
	# Perl modules - 5.12
        tspkg { [perl512,
		perl512-Crypt-DES,
		perl512-Crypt-SSLeay,
        	perl512-Curses,
        	perl512-DBD-SQLite,
        	perl512-DBD-mysql,
        	perl512-DateTime,
        	perl512-DateTime-Locale,
        	perl512-Digest-SHA1,
        	perl512-Event,
        	perl512-FCGI,
        	perl512-GD,
        	perl512-HTML-Parser,
        	perl512-IO-Tty,
        	perl512-IPC-ShareLite,
        	perl512-List-MoreUtils,
        	perl512-Net-DNS,
        	perl512-Params-Validate,
        	perl512-Socket6,
        	perl512-Sun-Solaris-Exacct,
        	perl512-Term-ReadKey,
        	perl512-XML-Parser,
		perl512-Mouse,
		perl512-Sub-Name,
		perl512-Params-Util,
		perl512-Moose,
		perl512-D-GlobalDestruction,
		perl512-DB-File,
		perl512-Net-SSLeay,
		perl512-Encode-Detect,
		perl512-Crypt-OpenSSL-Random,
		perl512-Crypt-OpenSSL-RSA,
		perl512-BerkeleyDB,
		perl512-Clone,
		perl512-Text-Unaccent,
		perl512-YAML-LibYAML,
		perl512-DBI,
		perl512-CSS-Minifier-XS,
		perl512-JS-Minifier-XS,
		perl512-NetAddr-IP,
		perl512-DBD-Pg,
		perl512-JSON-XS,
		perl512-Unix-Syslog,
		perl512-Convert-UUlib,
		perl512-svn,
		perl512-Crypt-OpenSSL-Bignum,
		perl512-Crypt-OpenSSL-DSA,
		perl512-Digest-BubbleBabble,
		perl512-MIME-Base32,
		perl512-Net-DNS-SEC,
		perl512-Eval-Closure,
		perl512-Math-Round,
		perl512-Regexp-RegGrp,
		perl512-Kstat
		
	]: ;
	
		# /opt/ts/bin/cronjob used to be in TScronjob, but now
		# it's in TSperl512-App-Cronjob.
		# 
		perl512-App-Cronjob: ;
	}
		
	# Perl modules that should not be installed, but might exist on
	# old systems.
	tspkg {
		[perl512-Algorithm-Diff,
		perl512-Hash-Merge,
		perl512-Net-IP,
		perl512-Net-Ident,
		perl512-URI,
		perl512-HTML-Tagset,
		perl512-POE-Test-Loops,
		perl512-POE,
		perl512-XML-Simple,
		perl512-HTTP-Server-Simple,
		perl512-WWW-Mechanize,
		perl512-UNIVERSAL-moniker,
		perl512-Try-Tiny,
		perl512-TimeDate,
		perl512-Tie-Restore,
		perl512-Text-Template,
		perl512-Text-Markdown,
		perl512-Text-Diff,
		perl512-Task-Weaken,
		perl512-Sys-Hostname-Long,
		perl512-Sub-Install,
		perl512-String-Flogger,
		perl512-Data-OptList,
		perl512-Sub-Exporter,
		perl512-Scope-Guard,
        	perl512-POE-Filter-IRCD,
        	perl512-POE-C-Pluggable,
        	perl512-POE-C-IRC,
		perl512-Net-Server,
        	perl512-Digest-HMAC,
		perl512-MRO-Compat,
        	perl512-Net-SNMP,
		perl512-Mail-DKIM,
        	perl512-Net-Netmask,
		perl512-JSON,
		perl512-Log-Dispatchouli,
		perl512-MailTools,
		perl512-IO-stringy,
		perl512-IPC-Run3,
		perl512-Log-Log4perl,
		perl512-Net-DNSBLLookup,
		perl512-IO-Socket-SSL,
		perl512-Ima-DBI,
        	perl512-IO-Socket-INET6,
        	perl512-HTML-Tree,
		perl512-Log-Dispatch-Array,
        	perl512-HTML-Template,
        	perl512-Error,
		perl512-Email-Simple,
		perl512-GetoptLongDescriptive,
		perl512-Email-Sender,
		perl512-Email-Address,
		perl512-Email-Abstract,
		perl512-IO-Multiplex,
        	perl512-DT-Format-Duration,
        	perl512-DateTime-TimeZone,
		perl512-Class-Trigger,
		perl512-Log-Dispatch,
		perl512-Class-Data-Inheritable,
		perl512-DBIx-ContextualFetch,
        	perl512-CGI-Cache,
		perl512-Email-Date-Format,
		perl512-Class-MOP,
        	perl512-Cache-Cache,
		perl512-Class-DBI,
		perl512-Class-Accessor,
		perl512-LWP]: ensure => absent;
	}

	# Solaris ships its own Perl, but we don't like it.  Make sure
	# /usr/bin/perl points to our version.
	file {
		"/usr/bin/perl5.12":	ensure => "/opt/ts/perl/5.12/bin/perl";
		# Uncomment this when 5.12 should become the default
		"/usr/bin/perl":	ensure => "perl5.12";
	}
}
