#
#ident	"@(#)pam.conf	1.31	07/12/07 SMI"
#
# Copyright 2007 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#
# PAM configuration
#
# Unless explicitly defined, all services use the modules
# defined in the "other" section.
#
# Modules are defined with relative pathnames, i.e., they are
# relative to /usr/lib/security/$ISA. Absolute path names, as
# present in this file in previous releases are still acceptable.
#
# Authentication management
#
# login service (explicit because of pam_dial_auth)
#
login	auth requisite		pam_authtok_get.so.1
login	auth required		pam_dhkeys.so.1
login	auth required		pam_unix_cred.so.1
login	auth binding		pam_unix_auth.so.1 server_policy
login	auth required		pam_ldap.so.1 try_first_pass
login	auth required		pam_dial_auth.so.1

#
# rlogin service (explicit because of pam_rhost_auth)
#
rlogin	auth sufficient		pam_rhosts_auth.so.1
rlogin	auth requisite		pam_authtok_get.so.1
rlogin	auth required		pam_dhkeys.so.1
rlogin	auth required		pam_unix_cred.so.1
rlogin	auth binding		pam_unix_auth.so.1 server_policy
rlogin	auth required		pam_ldap.so.1
#
# Kerberized rlogin service
#
krlogin	auth required		pam_unix_cred.so.1
krlogin	auth required		pam_krb5.so.1
#
# rsh service (explicit because of pam_rhost_auth,
# and pam_unix_auth for meaningful pam_setcred)
#
rsh	auth sufficient		pam_rhosts_auth.so.1
rsh	auth required		pam_unix_cred.so.1
#
# Kerberized rsh service
#
krsh	auth required		pam_unix_cred.so.1
krsh	auth required		pam_krb5.so.1
#
# Kerberized telnet service
#
ktelnet	auth required		pam_unix_cred.so.1
ktelnet	auth required		pam_krb5.so.1
#
# PPP service (explicit because of pam_dial_auth)
#
ppp	auth requisite		pam_authtok_get.so.1
ppp	auth required		pam_dhkeys.so.1
ppp	auth required		pam_unix_cred.so.1
ppp	auth required		pam_unix_auth.so.1
ppp	auth required		pam_dial_auth.so.1

# Don't allow LDAP authentication for ssh
sshd-password   auth requisite          pam_authtok_get.so.1
sshd-password   auth required           pam_dhkeys.so.1
sshd-password   auth required           pam_unix_cred.so.1
sshd-password   auth required           pam_unix_auth.so.1 server_policy
sshd-kbdint     auth requisite          pam_authtok_get.so.1
sshd-kbdint     auth required           pam_dhkeys.so.1
sshd-kbdint     auth required           pam_unix_cred.so.1
sshd-kbdint     auth required           pam_unix_auth.so.1 server_policy
sshd		auth requisite          pam_authtok_get.so.1
sshd		auth required           pam_dhkeys.so.1
sshd		auth required           pam_unix_cred.so.1
sshd		auth required           pam_unix_auth.so.1 server_policy

#
# Default definitions for Authentication management
# Used when service name is not explicitly mentioned for authentication
#
other	auth requisite		pam_authtok_get.so.1
other	auth required		pam_dhkeys.so.1
other	auth required		pam_unix_cred.so.1
other	auth binding		pam_unix_auth.so.1 server_policy
other	auth required		pam_ldap.so.1 try_first_pass

#
# passwd command (explicit because of a different authentication module)
#
passwd  auth binding            pam_passwd_auth.so.1 server_policy
passwd  auth required           pam_ldap.so.1 

#
# cron service (explicit because of non-usage of pam_roles.so.1)
#
cron	account required	pam_unix_account.so.1
#
# Default definition for Account management
# Used when service name is not explicitly mentioned for account management
#
other	account requisite	pam_roles.so.1
other	account binding		pam_unix_account.so.1
other	account required	pam_ldap.so.1
#
# Default definition for Session management
# Used when service name is not explicitly mentioned for session management
#
other	session required	pam_unix_session.so.1
#
# Default definition for Password management
# Used when service name is not explicitly mentioned for password management
#
other	password required	pam_dhkeys.so.1
other	password requisite	pam_authtok_get.so.1
other	password requisite	pam_authtok_check.so.1
other	password required	pam_authtok_store.so.1 server_policy
#
# Support for Kerberos V5 authentication and example configurations can
# be found in the pam_krb5(5) man page under the "EXAMPLES" section.
#
