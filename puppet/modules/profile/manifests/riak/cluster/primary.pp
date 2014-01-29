class profile::riak::cluster::primary (
	){

		$paths = [ '/bin', '/usr/bin', '/usr/sbin/', '/usr/local/bin', '/opt/ruby/bin' ]

		exec { "check-for-changes":
			command => "date > /var/log/riak/puppet_detected-changes.log", 
			path => $paths,
			unless => "riak_puppet_helper all_defined_are_valid",
			notify => [Exec["wait-for-joins"]],
		}

		exec { "wait-for-joins":
			command => "riak_puppet_helper all_defined_have_joined",
			path => $paths,
			tries => 10,
			try_sleep => 120,
			refreshonly => true,
			notify => [Exec["riak-plan"]]
		}

		exec { "riak-plan":
			command => 'riak-admin cluster plan > /var/log/riak/puppet_riak-admin-cluster-plan.log',
			path => $paths,
			refreshonly => true,
			notify => [Exec["riak-commit"]]
		}

		exec { "riak-commit":
			command => 'riak-admin cluster commit > /var/log/riak/puppet_riak-admin-cluster-commit.log',
			path => $paths,
			refreshonly => true,
			notify => [Exec["validate-ownership"]]
		}

		exec { "validate-ownership":
			command => "riak_puppet_helper all_joined_are_valid",
			path => $paths,
			refreshonly => true,
			tries => 20,
			try_sleep => 30,
		}

}