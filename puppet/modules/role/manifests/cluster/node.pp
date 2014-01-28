class role::cluster::node {
	include profile::base
	include profile::riak::member
	include profile::riak::riak_kv
	include profile::riak::riak_cs
}
