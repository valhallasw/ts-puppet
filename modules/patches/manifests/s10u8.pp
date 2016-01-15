class patches::s10u8 {
	# Patches for Solaris 10 U8 systems

	patch { "119255": rev => 71 }	# SunOS 5.10_x86: Install and Patch Utilities Patch
	patch { "119398": rev => 09,	# SunOS 10_x86: Patch for North America Region locale issues
		package => "SUNWnamos" }
	patch { "119961": rev => 06 }	# SunOS 5.10_x86, x64, Patch for profiling libraries and assembler
	patch { "119964": rev => 19 }	# SunOS 5.10_x86: Shared library patch for C++_x86
	patch { "120273": rev => 28,	# SunOS 5.10_x86: SMA patch
		notify => Service["svc:/application/management/sma:default"] }
	patch { "121431": rev => 44 }	# SunOS 5.8_x86 5.9_x86 5.10_x86: Live Upgrade Patch
	patch { "124631": rev => 32 }	# SunOS 5.10_x86: System Administration Applications, Network, and C
	patch { "141517": rev => 05 }	# SunOS 5.10_x86: zoneinfo patch
	patch { "119214": rev => 21 }	# NSS_NSPR_JSS 3.12.5_x86: NSPR 4.8.2 / NSS 3.12.5 / JSS 4.3.1
	patch { "141031": rev => 08 }	# SunOS 5.10_x86: passwd patch
	patch { "141525": rev => 07 }	# SunOS 5.10_x86: ssh and openssl patch
	patch { "141533": rev => 03 }	# SunOS 5.10_x86: in.mpathd patch
	patch { "142262": rev => 01 }	# SunOS 5.10_x86: rpc.mdcommd patch
	patch { "142540": rev => 02 }	# SunOS 5.10_x86: libzonecfg.so.1 patch
	patch { "143123": rev => 01 }	# SunOS 5.10_x86: format patch	
}
