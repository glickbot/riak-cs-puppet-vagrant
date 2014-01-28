class profile::riak::stepa {
	$time = strftime("%R")
	exec { 'sleep stepa':
		command => '/bin/sleep 5',
	}
	file { "/tmp/stepa":
		ensure => present,
		content => "The time is $time",
		require => Exec['sleep stepa']
	}
}