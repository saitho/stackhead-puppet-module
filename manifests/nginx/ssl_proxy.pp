define stackhead::nginx::ssl_proxy (
  $proxy_port,
  $listen_port = 80,
  $server_name = $name,
) {
  include nginx

  # ensure ssl certificate exist to start up nginx
  # if no certificate files are found, use fake certificates
  $chain_path = "${stackhead::project_certificate_dir}/fullchain.pem"
  $privkey_path = "${stackhead::project_certificate_dir}/privkey.pem"

  $chain_exists = find_file($chain_path)
  if $chain_exists {
    exec { 'fake_chain':
      command => "ln -s ${stackhead::certificate_dir}/fullchain_snakeoil.pem ${chain_path}",
      unless  => "test -e ${chain_path}",
      creates => $chain_path,
      path    => '/bin',
    }
    exec { 'fake_key':
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
    ssl             => true,
    ssl_cert        => $chain_path,
    ssl_key         => $privkey_path,
    ssl_redirect    => true,
    proxy           => "http://127.0.0.1:${proxy_port}",
  }

  # Redirect for acme
  nginx::resource::location { "${name}_acme":
    ensure   => present,
    server   => $name,
    location => '/.well-known/acme-challenge',
    alias    => "${stackhead::acme_dir}/${server_name}"
  }


  #     location /.well-known/acme-challenge {
  #         alias {{ stackhead__acme_folder }}/{{ nginx_servername }};
  #
  #         location ~ /.well-known/acme-challenge/(.*) {
  #             default_type text/plain;
  #         }
  #     }
}