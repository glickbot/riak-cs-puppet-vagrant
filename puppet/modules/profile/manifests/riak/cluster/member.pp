class profile::riak::cluster::member (
	$riak_nodename_first = $profile::riak::cluster::riak_nodename_first,
	) {
		notice ( "This is not the primary node, a member of the cluster" )
		exec { "riak-join":
			command => "riak-admin cluster join ${riak_nodename_first}",
			onlyif => "riak_puppet_helper is_only_member_in_cluster",
			unless => "riak_puppet_helper is_in_correct_cluster",
			path => ['/usr/bin', '/usr/sbin/', '/bin', '/usr/local/bin', '/opt/ruby/bin'],
			tries => 10,
			try_sleep => 60,
		}
}