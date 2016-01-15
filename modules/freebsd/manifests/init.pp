import "*"

define shell_config($file, $key, $value, $ensure = 'present') {
  case $ensure {
    default: { err ( "unknown ensure value ${ensure}" ) }
    present: {
      exec {
        "shell_config_unique_$ensure '$file$key'":
          unless => "/bin/test `/usr/bin/grep -cE '^[ \t]*$key=' -- $file` -le 1",
          command => "/usr/bin/sed -i '' -e '/$key=\".*\"/d' $file";
        "shell_config_create_$ensure '$file$key'":
          unless => "/usr/bin/grep -qE '^[ \t]*$key=' -- $file",
          command => "/usr/bin/printf '%s=\"%s\"\n' '$key' '$value' >> '${file}'";
        "shell_config_update_$ensure '$file$key'":
          unless => "/usr/bin/grep -qE '^[ \t]*$key=\"$value\"' -- $file",
          command => "/usr/bin/sed -i '' -e 's/$key=\".*\"/$key=\"$value\"/' $file";
      }
    }
    absent: {
      exec {  "shell_config_delete_$ensure $file$key":
          onlyif => "/usr/bin/grep -qE '^[ \t]*$key=' -- $file",
          command => "/usr/bin/sed -i '' -e '/$key=\".*\"/d' $file";
      }
    }
  }
}

define periodic_conf($value) {
  shell_config {  "periodic_conf_${name}":
    file => '/etc/periodic.conf',
    key => $name,
    value => $value
  }
}

define rc_conf_local($value) {
  shell_config { "rc_conf_local_${name}":
    file => "/etc/rc.conf.local",
    key => $name,
    value => $value;
  }
}

class freebsd {
	include freebsd::files
	include freebsd::services
	include bsdsoftware

	rc_conf_local {
		update_motd: value => NO;
	}

}
