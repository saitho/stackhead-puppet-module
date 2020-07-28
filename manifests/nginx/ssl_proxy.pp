define stackhead::nginx::ssl_proxy (
  String $project_name,
  Integer $proxy_port,
  Integer $listen_port              = 80,
  String  $server_name              = $name,
  Boolean $use_ssl                  = true,
  Enum['present', 'absent'] $ensure = 'present',
  $auth_basic                       = undef,
  $auth_basic_user_file             = undef,
) {
  include nginx

  # ensure ssl certificate exist to start up nginx
  # if no certificate files are found, symlink fake certificates
  $chain_path = "${stackhead::project_certificate_dir}/fullchain.pem"
  $privkey_path = "${stackhead::project_certificate_dir}/privkey.pem"

  if $use_ssl and (!find_file($chain_path) or !find_file($privkey_path)) {
    exec { "fake_chain-${name}":
      command => "ln -s ${stackhead::certificate_dir}/fullchain_snakeoil.pem ${chain_path}",
      creates => $chain_path,
      path    => '/bin',
    }
    exec { "fake_key-${name}":
      command => "ln -s ${stackhead::certificate_dir}/privkey_snakeoil.pem ${privkey_path}",
      creates => $privkey_path,
      path    => '/bin',
    }
  }

  # Create Nginx server configuration
  nginx::resource::server { $name:
    ensure               => $ensure,
    server_name          => [$server_name],
    auth_basic           => $auth_basic,
    auth_basic_user_file => $auth_basic_user_file,
    ssl                  => $use_ssl,
    ssl_cert             => $chain_path,
    ssl_key              => $privkey_path,
    ssl_redirect         => $use_ssl,
    location_cfg_prepend => { client_max_body_size => '10G' },
    proxy                => "http://127.0.0.1:${proxy_port}",
  }

  # Redirect for acme
  nginx::resource::location { "${name}_acme":
    ensure              => $use_ssl ? { false => 'absent', default => 'present' },
    server              => $name,
    index_files         => [],
    location            => '/.well-known/acme-challenge',
    location_alias      => "${stackhead::acme_dir}/${project_name}/.well-known/acme-challenge",
    location_cfg_append => { 'default_type' => 'text/plain' }
  }

  #     location /.well-known/acme-challenge {
  #         alias {{ stackhead__acme_folder }}/{{ nginx_servername }};
  #
  #         location ~ /.well-known/acme-challenge/(.*) {
  #             default_type text/plain;
  #         }
  #     }
}