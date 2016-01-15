class base::authorized_keys {
	ssh_authorized_key { "root": 
		key => "AAAAB3NzaC1yc2EAAAABIwAAAQEAy4cbvmVbLgtfbIfbGVBH+EDc9ysEMpzX26EFzf+96+8VIsG04nfvYiwy0WHgHY2i+Qk43SMJyW40W02KswBXE7DewsXpbl9q7cz24yiKDUNC1k7kn4cT/ek+Cyg1GeE1S2E7HzF2sFKCvsXjBES6Ty3TPw6YonvWuhr1rvhum9l54tMlK2UEIItCoFSuzvGv87SW03WOdIqFWoxpFbcVPJOUFksON8PEeJWXXkAlInwoAYxA2tiDUUXDs193RKJz70smZa0HohyugkNwoPpIugr3/RL2JuwbuAR+q9o0C27WDKgJOFTcKlOZdNNSD7UvTIFBax6D46un9VC04sdulQ==",
		ensure => present,
		type => rsa,
		user => "root"
	}
}
