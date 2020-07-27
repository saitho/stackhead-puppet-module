define stackhead::nginx::ssl_proxy (
  String $stackhead_project_name,
  Integer $proxy_port,
  Integer $listen_port = 80,
  String $server_name  = $name,
  Boolean $use_ssl     = true,
) {
  include nginx

  # ensure ssl certificate exist to start up nginx
  # if no certificate files are found, use fake certificates
  $chain_path = "${stackhead::project_certificate_dir}/fullchain.pem"
  $privkey_path = "${stackhead::project_certificate_dir}/privkey.pem"

  $chain_exists = find_file($chain_path)
  if $use_ssl and !$chain_exists {
    exec { "fake_chain-${stackhead_project_name}":
      command => "ln -s ${stackhead::certificate_dir}/fullchain_snakeoil.pem ${chain_path}",
      unless  => "test -e ${chain_path}",
      creates => $chain_path,
      path    => '/bin',
    }
    exec { "fake_key-${stackhead_project_name}":
      command => "ln -s ${stackhead::certificate_dir}/privkey_snakeoil.pem ${privkey_path}",
      unless  => "test -e ${privkey_path}",
      creates => $privkey_path,
      path    => '/bin',
    }
  }

  # Create Nginx server configuration
  nginx::resource::server { $name:
    ensure          => present,
    server_name     => [$server_name],
    ssl             => $use_ssl,
    ssl_cert        => $chain_path,
    ssl_key         => $privkey_path,
    ssl_redirect    => $use_ssl,
    proxy           => "http://127.0.0.1:${proxy_port}",
  }

  # Redirect for acme
  if $use_ssl {
    nginx::resource::location { "${name}_acme":
      ensure         => present,
      server         => $name,
      location       => '/.well-known/acme-challenge',
      location_alias => "${stackhead::acme_dir}/${server_name}"
    }
  }

  #     location /.well-known/acme-challenge {
  #         alias {{ stackhead__acme_folder }}/{{ nginx_servername }};
  #
  #         location ~ /.well-known/acme-challenge/(.*) {
  #             default_type text/plain;
  #         }
  #     }
}