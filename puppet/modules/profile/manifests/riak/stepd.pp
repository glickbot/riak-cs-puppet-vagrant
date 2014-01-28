class profile::riak::stepd {
	exec { 'exec stepd':
		command => '/bin/cat /tmp/stepa /tmp/stepb > /tmp/stepd',
		creates => '/tmp/stepc',
	}
}