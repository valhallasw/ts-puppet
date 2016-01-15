import "*"

class bsdsoftware::user {
	# Software that should be install on user (login) servers

	include bsdsoftware::php53
	include bsdsoftware::mysql_client

	yum {
		curl: ;
	}
}
