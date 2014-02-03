#!/bin/bash


puppet_opts=""
#puppet_opts=" --noop --verbose --debug"
puppet_opts=" --detailed-exitcodes"
puppet_opts+=" --hiera_config /opt/occam/hiera.yaml"
#puppet_opts+=" --graph --graphdir /opt/occam/puppet/graphs/node1/"
puppet_opts+=" --modulepath '/etc/puppet/modules:/opt/occam/puppet/modules'"
puppet_opts+=" --manifestdir /opt/occam/puppet/manifests"
puppet_opts+=" /opt/occam/puppet/manifests/site.pp"


if [ "$1" == "--noop" ]; then
  echo "apt-get install -y screen"
  echo "puppet apply $puppet_opts"
else
  apt-get install -y screen
  screen -L -d -m puppet apply $puppet_opts
fi
