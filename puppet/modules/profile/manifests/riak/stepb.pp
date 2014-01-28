class profile::riak::stepb {
	$time = strftime("%R")
	exec { 'sleep stepb':
		command => '/bin/sleep 2',
	}
	file { "/tmp/stepb": 
		ensure => present,
		content => "The time is $time",
		require => Exec['sleep stepb']
	}
}