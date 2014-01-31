class profile::riak::cluster::admin_user (
		$user_id = "admin",
		$user_name = "Default Admin",
		$user_email = "root@localhost",
		$user_key = "XXXX",
		$user_secret = "XXXX"
	){

	exec { "Riak CS Admin User":
		command => "riak-cs-tool create-user \"${user_name}\" \"${user_email}\" \"${user_key}\" \"${user_secret}\" \"${user_id}\"",
		path => [ '/bin', '/usr/bin', '/usr/sbin/', '/usr/local/bin' ],
		unless => "riak-cs-tool verify-user \"${user_key}\""
	}
}