# Used to build Stanchion instance

class profile::riak::stanchion (
    $riakcs_admin_key = MTCJNUVLE8R4GQNNDNC1,
    $riakcs_secret = 'nslAllQMx1IUN6cXnJOJa3a3eK9Byua-P0jGVQ==',
    $riak_address = '127.0.0.1',
    $riak_hostname = $::fqdn,
    $riak_pb_port = 8087,
    $erlang_cookie = riak,
    $stanchion_version = '1.4.3-1',
) {
  class { '::riak::stanchion':
    ulimit              => 65536,
    version             => $stanchion_version,
    service_autorestart => false,
    ulimit_etc_default  => true,
    cfg                 => {
      stanchion         => {
      riak_ip           => $riak_address,
      riak_pb_port      => $riak_pb_port,
        admin_key       => $riakcs_admin_key,
        admin_secret    => $riakcs_secret,
      },
    },
    vmargs_cfg          => {
        '-name'         => "stanchion@$riak_hostname",
        '-setcookie'    => $erlang_cookie,
    }
  }
}