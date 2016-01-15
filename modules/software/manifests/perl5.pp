# Version-neutral Perl modules.
class software::perl5 {
	case $operatingsystem {
		debian: {
			package {
				perl: ;
				libdbd-mysql-perl: ;
				libdbd-sqlite: ;
				libdbd-sqlite3: ;
				libdbd-sqlite3-perl: ;
				libdbi-perl: ;
				libfilesys-df-perl: ;
				libimage-exiftool-perl: ;
				libmediawiki-api-perl: ;
				libpoe-perl: ;
				libtext-diff-perl: ;
				libxml-libxml-perl: ;
				libxml-sax-expat-perl: ;
				libxml-simple-perl: ;
			}
		}

		solaris: {
			import "utils"
			tspkg {
				perl5-Algorithm-Diff: ;
				perl5-Devel-StackTrace: ;
				perl5-Hash-Merge: ;
				perl5-HTML-Tagset: ;
				perl5-LWP: ;
				perl5-Net-IP: ;
				perl5-Net-Ident: ;
				perl5-URI: ;
				perl5-POE-Test-Loops: ;
		
				perl5-POE: ;
				perl5-XML-Simple: ;
				perl5-HTTP-Server-Simple: ;
				perl5-WWW-Mechanize: ;
				perl5-UNIVERSAL-moniker: ;
				perl5-Try-Tiny: ;
				perl5-TimeDate: ;
				perl5-Tie-Restore: ;
				perl5-Text-Template: ;
				perl5-Test-Differences: ;
				perl5-Sub-Uplevel: ;
				perl5-Test-Exception: ;
				perl5-Text-Markdown: ;
				perl5-Text-Diff: ;
				perl5-Task-Weaken: ;
				perl5-Sys-Hostname-Long: ;
				perl5-Sub-Install: ;
				perl5-Data-OptList: ;
				perl5-Sub-Exporter: ;
				perl5-String-Flogger: ;
				perl5-Scope-Guard: ;
				perl5-POE-Filter-IRCD: ;
				perl5-POE-C-Pluggable: ;
				perl5-POE-C-IRC: ;
				perl5-POE-C-Syndicator: ;
				perl5-Net-Server: ;
				perl5-Digest-HMAC: ;
				perl5-Net-SNMP: ;
				perl5-Net-Netmask: ;
				perl5-Net-DNSBLLookup: ;
				perl5-MailTools: ;
				perl5-Throwable: ;
				perl5-Mail-DKIM: ;
				perl5-MRO-Compat: ;
				perl5-Log-Log4perl: ;
				perl5-Test-Tester: ;
				perl5-Test-NoWarnings: ;
				perl5-Test-Deep: ;
				perl5-Log-Dispatchouli: ;
				perl5-Log-Dispatch: ;
				perl5-Log-Dispatch-Array: ;
				perl5-JSON: ;
				perl5-Ima-DBI: ;
				perl5-IPC-Run3: ;
				perl5-IO-stringy: ;
				perl5-IO-Socket-SSL: ;
		        	perl5-IO-Socket-INET6: ;
				perl5-IO-Multiplex: ;
		        	perl5-HTML-Tree: ;
		        	perl5-HTML-Template: ;
				perl5-GetoptLongDescriptive: ;
		        	perl5-Error: ;
				perl5-Email-Simple: ;
				perl5-Capture-Tiny: ;
				perl5-Email-Sender: ;
				perl5-Email-Date-Format: ;
				perl5-Email-Address: ;
				perl5-Email-Abstract: ;
				perl5-Class-Singleton: ;
		        	perl5-DateTime-TimeZone: ;
		        	perl5-DT-Format-Duration: ;
				perl5-DBIx-ContextualFetch: ;
				perl5-Class-Trigger: ;
				perl5-Class-Data-Inheritable: ;
				perl5-Class-DBI: ;
				perl5-Class-Accessor: ;
		        	perl5-Cache-Cache: ;
		        	perl5-CGI-Cache: ;
				perl5-File-Slurp: ;
				perl5-HTML-Packer: ;
				perl5-DateTime-Locale: ;
				perl5-Package-Stash: ;
				perl5-Switch: ;
				perl5-Syntax-Highlight-Perl-I: ;
				perl5-Time-modules: ;
				perl5-App-cpanminus: ;
				perl5-Object-Pluggable: ;
				perl5-Pkg-DeprecationManager: ;
				perl5-Class-Load: ;
				perl5-Bot-BasicBot: ;
				perl5-Convert-ASN1: ;
				perl5-Net-LDAP: ;
				perl5-common-sense: ;
				perl5-Expect: ;
				perl5-MIME-tools: ;
				perl5-Convert-BinHex: ;
				perl5-Convert-TNEF: ;
				perl5-Archive-Zip: ;
				perl5-CGI-QuickForm: ;
				perl5-razor-agents: ;
				perl5-HTML-Form: ;
				perl5-HTTP-Cookies: ;
				perl5-HTTP-Daemon: ;
				perl5-HTTP-Date: ;
				perl5-HTTP-Message: ;
				perl5-HTTP-Negotiate: ;
				perl5-IRC-Utils: ;
				perl5-LWP-MediaTypes: ;
				perl5-Net-HTTP: ;
				perl5-WWW-RobotRules: ;
				perl5-Encode-Locale: ;
			}
		
			tspkg {
				[perl5-DBI,
				 perl5-Sub-Name,
				 perl5-Syntax-Highlight-Perl
				]: ensure => absent;
			}
		}		
	}
}
		
