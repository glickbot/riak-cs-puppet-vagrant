#
# Used to build out Riak instance
#
# === Parameters
#
# [riak_address] Address for Riak to listen (used by Riak CS)
# [riak_hostname] Hostname to use for clustering Riak, defaults to fqdn
# [riak_http_port] Port to bind http webservice to, defaults to 8098
# [riak_pb_port] Port to bind protocol buffers, defaults to 8087
# [riak_handoff_port] Erlang handoff ports, defaults to 8099
# [erlang_cookie] Erlang VM cookie, should be the same for all connected nodes
# [riak_ring_size] Riak ring creation size, defaults to 256
# [riak_cs_ebin_path] Location of Riak CS ebin files for multibackend config

class profile::riak::riak_kv (
    $riak_address = $::ipaddress,
    $riak_hostname = $::fqdn,
    $riak_http_port = 8098,
    $riak_pb_port = 8087,
    $riak_handoff_port = 8099,
    $erlang_cookie = riak,
    $riak_ring_size = 256,
    $riak_cs_ebin_path = '/usr/lib/riak-cs/lib/riak_cs-1.4.3/ebin',
    $riak_version = '1.4.2-1'
){
  class { '::riak':
    ulimit                          => 65536,
    version                         => $riak_version,
    service_autorestart             => false,
    ulimit_etc_default              => true,
    cfg                             => {
      riak_api                      => {
        pb_ip                       => $riak_address,
        pb_port                     => $riak_pb_port,
      },
      riak_core                     => {
        ring_creation_size          => $riak_ring_size,
        default_bucket_props        => {
          allow_mult                => true
        },
        handoff_port                => $riak_handoff_port,
      },
      riak_kv                       => {
        add_paths                   => [$riak_cs_ebin_path],
        storage_backend             => '__atom_riak_cs_kv_multi_backend',
        multi_backend_prefix_list   => [
                                      ['__tuple',
                                      '__binary_0b:',
                                      '__atom_be_default']
        ],
        multi_backend_default       => '__atom_be_default',
        multi_backend               => [
                          ['__tuple',
                          '__atom_be_default',
                          '__atom_riak_kv_eleveldb_backend',
                          {
          max_open_files            => 50,
          data_root                 => '/var/lib/riak/leveldb',
                          }
                        ],
                        ['__tuple',
                        '__atom_be_blocks',
                        '__atom_riak_kv_bitcask_backend', {
          data_root                 => '/var/lib/riak/bitcask',
                          }],
        ],
      },
    },
    vmargs_cfg                      => {
      '-name'                       => "riak@$riak_hostname",
      '-setcookie'                  => $erlang_cookie,
    }
  }
}
