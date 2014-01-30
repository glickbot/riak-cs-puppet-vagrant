#!/bin/bash

apt-get install -y screen

puppet_opts=""
#puppet_opts=" --noop --verbose --debug"
puppet_opts=" --detailed-exitcodes"
puppet_opts+=" --hiera_config /opt/occam/hiera.yaml"
#puppet_opts+=" --graph --graphdir /opt/occam/puppet/graphs/node1/"
puppet_opts+=" --modulepath '/etc/puppet/modules:/opt/occam/puppet/modules'"
puppet_opts+=" --manifestdir /opt/occam/puppet/manifests"
puppet_opts+=" /opt/occam/puppet/manifests/site.pp"

screen -L -d -m puppet apply $puppet_opts
