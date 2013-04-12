# = Define: portage::makeconf
#
# Adds sections to make.conf
#
# == Parameters
#
# [*target*]
#
# (**Namevar**: If omitted, this parameter's value defaults to the resource's
# title.)
#
# The name of the make.conf variable
#
# [*content*]
#
# The content of the configuration fragment. Must be of the form used
# by concat::fragment.
#
# [*ensure*]
#
# The ensure state of the makeconf section.
#
# [*order*]
#
# The order in which the variable should appear in make.conf
#
# == Example
#
#     portage::makeconf { 'use':
#       ensure  => present,
#       content => '-X ldap ruby',
#     }

define portage::makeconf(
  $ensure = present,
  $target = '',
  $content = '',
  $order = 10,
) {
  include concat::setup
  include portage

  $var_name = $target ? {
    ''      => $name,
    default => $target,
  }

  concat::fragment { $name:
    ensure  => $ensure,
    content => template('portage/makeconf.conf.erb'),
    target  => $portage::make_conf,
    order   => $order,
  }
}
