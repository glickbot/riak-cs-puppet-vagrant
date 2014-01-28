class profile::riak::stepc {
	exec { 'stepc exec':
		command => '/bin/cat /tmp/stepa /tmp/stepb > /tmp/stepc',
		creates => '/tmp/stepc',
	}
}