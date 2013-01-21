import 'fix'

node 'vm-licpro' {

  class { 'bazinga::roles::base':
    vagrant => true
  }

  include bazinga::apt
  include bazinga::roles::mysql
  include bazinga::roles::php_mysql
  include bazinga::roles::apache_fpm
  include bazinga::php::phpsh

  bazinga::apache_fpm::vhost { 'www':
    server_name  => 'www.33.33.33.10.xip.io',
    doc_root     => '/var/www',
    server_admin => 'root@vm-licpro',
    priority     => 1,
  }

  bazinga::apache_fpm::vhost { 'uframework':
    server_name  => 'uframework.33.33.33.10.xip.io',
    doc_root     => '/var/www/uframework/web',
    server_admin => 'root@vm-licpro',
  }

  bazinga::apache_fpm::vhost { 'uframework-backup':
    doc_root     => '/var/www/uframework/web',
    server_admin => 'root@vm-licpro',
    port         => 81,
  }

  bazinga::php::set_var { 'display_errors':
    value    => 'On',
    file_ini => $php::params::fpm_ini,
  }

  bazinga::php::set_var { 'html_errors':
    value    => 'On',
    file_ini => $php::params::fpm_ini,
  }

  package { 'nano':
    ensure => absent
  }

  package { 'tree':
    ensure => present
  }
}
