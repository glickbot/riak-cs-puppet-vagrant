class profile::riak::cluster (
	$clusters = hiera('clusters', {}),
	$riak_hostname = hiera('riak_hostname', $fqdn),
) {
	$member_of = member_of_key($clusters, $riak_hostname)
	$cluster = $member_of[0]
	$riak_nodename = "riak@${riak_hostname}"
	include profile::riak::riak_kv
	include profile::riak::riak_cs
  	file { '/usr/local/bin/riak_puppet_helper':
    	ensure  => present,
    	mode    => '0755',
    	content => template('profile/riak/riak_puppet_helper.erb')
  	}
	notice("This node is a member of ${member_of}")
	if size($member_of) < 1 {
		warning("Profile::Riak::Cluster added, but not found in any cluster")
    } elsif size($member_of) > 1 {
    	$csize = size($member_of)
    	warning("Fqdn ${riak_hostname} found in ${csize} clusters: ${member_of}")
	} else {
		$cluster_node_list = sort($clusters[$cluster])
		$riak_hostname_first = $cluster_node_list[0]
		$riak_nodename_first = "riak@${riak_hostname_first}"
		notice("first member of cluster: ${riak_nodename_first}")
		if $riak_hostname == $riak_hostname_first {
			include profile::riak::stanchion
			include profile::riak::cluster::primary
			include profile::riak::cluster::admin_user
			Service['riak'] -> Service['stanchion']
			Service['riak'] -> Class['profile::riak::cluster::primary'] -> Class['profile::riak::cluster::admin_user']
		} else {
			include profile::riak::cluster::member
			Service['riak'] -> Class['profile::riak::cluster::member']
		}
	}
}
