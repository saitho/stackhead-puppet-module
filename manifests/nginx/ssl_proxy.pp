define stackhead::nginx::ssl_proxy (
  String $project_name,
  Integer $proxy_port,
  String  $server_name,
  String $basicauth_title,
  Integer $listen_port              = 80,
  Boolean $use_ssl                  = true,
  Enum['present', 'absent'] $ensure = 'present',
  Array $auth                       = [],
) {
  include nginx

  # ensure ssl certificate exist to start up nginx
  # if no certificate files are found, symlink fake certificates
  $chain_path = "${stackhead::project_certificate_dir}/fullchain.pem"
  $privkey_path = "${stackhead::project_certificate_dir}/privkey.pem"

  if $use_ssl and (!find_file($chain_path) or !find_file($privkey_path)) {
    exec { "fake_chain-${name}":
      command => "ln -sf ${stackhead::certificate_dir}/fullchain_snakeoil.pem ${chain_path}",
      creates => $chain_path,
      path    => '/bin',
    }
    exec { "fake_key-${name}":
      command => "ln -sf ${stackhead::certificate_dir}/privkey_snakeoil.pem ${privkey_path}",
      creates => $privkey_path,
      path    => '/bin',
    }
  }

  $basicauth_items = $auth.filter |Hash $item| { $item['type'] == 'basic' }
  $auth_basic_user_file = "${stackhead::htpasswd_path}/.${server_name}-${listen_port}"

  # Remove file to make sure it is recreated from scratch
  file { $auth_basic_user_file:
    ensure => 'absent'
  }
  # Create basic auth user file
  if $basicauth_items.length() > 0 {
    concat { $auth_basic_user_file:
      ensure  => $auth_basic_user_file != undef ? { true => 'present', default => 'absent' },
      require => file[$auth_basic_user_file],
    }

    $basicauth_items.each |Hash $auth| {
      concat::fragment { "${auth_basic_user_file}-user-${auth[username]}":
        target  => $auth_basic_user_file,
        content => "${auth[username]}:${pw_hash(auth[password], 'SHA-512', 'salt')}",
        require => concat[$auth_basic_user_file],
      }
    }
  }

  # Create Nginx server configuration
  nginx::resource::server { $name:
    ensure               => $ensure,
    server_name          => [$server_name],
    ssl                  => $use_ssl,
    ssl_cert             => $chain_path,
    ssl_key              => $privkey_path,
    ssl_redirect         => $use_ssl,
    location_cfg_prepend => { client_max_body_size => '10G' },
    use_default_location => false,
    require              => file[$auth_basic_user_file],
  }

  # Path for ACME challenges
  nginx::resource::location { "${name}_acme":
    ensure              => $use_ssl ? { false => 'absent', default => 'present' },
    server              => $name,
    index_files         => [],
    ssl                 => false,
    location            => '/.well-known/acme-challenge',
    location_alias      => "${stackhead::acme_dir}/${project_name}/.well-known/acme-challenge",
    location_cfg_append => { 'default_type' => 'text/plain' },
    require             => nginx::resource::server[$name],
  }

  # Proxy to Docker container
  nginx::resource::location { "${name}_container":
    ensure               => $ensure,
    server               => $name,
    index_files          => [],
    ssl                  => $use_ssl,
    ssl_only             => $use_ssl,
    location             => '/',
    proxy                => "http://127.0.0.1:${proxy_port}",
    auth_basic           => $basicauth_items.length() > 0 ? { true => $basicauth_title, default => undef},
    auth_basic_user_file => $auth_basic_user_file,
    require              => nginx::resource::server[$name],
  }
}