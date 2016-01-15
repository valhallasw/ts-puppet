class software::ucarp {
	tspkg {
		ucarp: require => Tspkg[libpcap];
	}
}
