class profile::riak::member (
	$clusters = hiera('clusters', {}),
	$riak_hostname = hiera('riak_hostname', $fqdn)
) {
	$member_of = member_of_key($clusters, $riak_hostname)
	include profile::riak::stepa
	include profile::riak::stepb
	notice("This node is a member of ${member_of}")
	if size($member_of) < 1 {
		warning("Profile::Riak::Member added, but not found in any cluster")
    } elsif size($member_of) > 1 {
    	$csize = size($member_of)
    	warning("Fqdn ${riak_hostname} found in ${csize} clusters: ${member_of}")
	} else {
		$cluster = $member_of[0]
		$sorted_list = sort($clusters[$cluster])
		$fnode = $sorted_list[0]
		notice("first member of cluster: ${sorted_list[0]}")
		if $friak_hostname == $fnode {
			notice ( "This node is the primary node" )
			include profile::riak::stepd
			Class['profile::riak::stepa'] -> 
				Class['profile::riak::stepb']->
					Class['profile::riak::stepd']
		} else {
			notice ( "This is not the primary node" )
			include profile::riak::stepc
			Class['profile::riak::stepa'] ->
				Class['profile::riak::stepb'] ->
					Class['profile::riak::stepc']
		}
	}
}