# Used to build Riak CS instance

class profile::riak::riak_cs (
    $riakcs_root_host = localhost,
    $riakcs_admin_key = MTCJNUVLE8R4GQNNDNC1,
    $riakcs_secret = 'nslAllQMx1IUN6cXnJOJa3a3eK9Byua-P0jGVQ==',
    $riak_address = $::ipaddress,
    $riakcs_address = $::ipaddress,
    $riak_hostname = $::fqdn,
    $riak_pb_port = 8087,
    $riak_handoff_port = 8099,
    $erlang_cookie = riak,
    $riakcs_version = '1.4.3-1',
    $riakcs_os_auth_url = 'http://localhost:35357/v2.0/'
) {
  class { '::riak::cs':
    ulimit                => 65536,
    version               => $riakcs_version,
    service_autorestart   => false,
    ulimit_etc_default    => true,
    # use the following to create the user
    #riak escript /usr/sbin/create_cs_user admin mn766s@att.com
    #MTCJNUVLE8R4GQNNDNC1 "nslAllQMx1IUN6cXnJOJa3a3eK9Byua-P0jGVQ==" admin
    cfg                   => {
      riak_cs             => {
        rewrite_module    => '__atom_riak_cs_oss_rewrite',
        auth_module       => '__atom_riak_cs_keystone_auth',
        os_operator_roles => [
          '__binary_admin',
          '__binary_swiftoperator',
          '__binary_cinnamon'],
        cs_root_host      => $riakcs_root_host,
        os_admin_token    => keystone_admin_token,
        os_auth_url       => $riakcs_os_auth_url,
        admin_key         => $riakcs_admin_key,
        admin_secret      => $riakcs_secret,
      },
    },
    vmargs_cfg    => {
        '-name'           => "riak-cs@$riak_hostname",
        '-setcookie'      => $erlang_cookie,
    }
  }
}