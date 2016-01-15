class auditing {

	case $operationsystem {

		solaris: {
			file {
			"audit_control":
				name => "/etc/security/audit_control", 
				owner => root, group => sys, mode => 644,
				source => "puppet:///auditing/audit_control";

			"audit_startup":
				name => "/etc/security/audit_startup",
				owner => root, group => root, mode => 755,
				source => "puppet:///auditing/audit_startup";

			"audit_user":
				name => "/etc/security/audit_user", 
				owner => root, group => sys, mode => 644,
				source => "puppet:///auditing/audit_user";

			"parseaudit":
				name => "/opt/local/bin/parseaudit",
				owner => root, group => root, mode => 755,
				source => "puppet:///auditing/parseaudit";

			"process_audit":
				name => "/opt/local/bin/process_audit",
				owner => root, group => root, mode => 755,
				source => "puppet:///auditing/process_audit";
			}
	
		        cron { 
		                # Start a new audit-log every day.
	                audit:
	                        command => "/usr/sbin/audit -n",
	                        user => root, minute => 15, hour => 4;
	        	}
		}
	}
}
