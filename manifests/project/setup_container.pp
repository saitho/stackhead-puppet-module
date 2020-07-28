define stackhead::project::setup_container (
  Array $domains,
  Array $services,
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $use_ssl = true,
  String $basicauth_title = 'Restricted area',
) {
  ###
  # NGINX
  ###

  # Setup Nginx configurations
  $domains.each |Hash $domain| {
    $domain[expose].each |Integer $index, Hash $expose| {

      $items = ('security' in domain and 'authentication' in domain[security]) ? {
        true => domain[security][authentication],
        default => []
      }

      stackhead::nginx::ssl_proxy { "${domain[domain]}-${expose[external_port]}":
        project_name    => $name,
        ensure          => $ensure,
        server_name     => $domain[domain],
        listen_port     => $expose[external_port],
        proxy_port      => $expose[internal_port],
        use_ssl         => $use_ssl,
        auth            => $items,
        basicauth_title => $basicauth_title,
      }
    }
  }

  ###
  # SSL CERTIFICATES
  ###
  if $use_ssl {
    class { 'letsencrypt':
      config => {
        email  => $stackhead::certificate_email,
        server => $stackhead::test ? {
          true => 'https://acme-staging-v02.api.letsencrypt.org/directory',
          default => 'https://acme-v02.api.letsencrypt.org/directory'
        },
      },
      renew_cron_ensure => 'present',
    }

    $domain_names = $domains.map |$item| { $item[domain] }

    letsencrypt::certonly { "${name}":
      ensure        => $ensure,
      domains       => $domain_names,
      webroot_paths => ["${stackhead::acme_dir}/${name}"],
      plugin        => 'webroot',
    }

    # Update symlink
    if $use_ssl {
      exec { "real_chain-${name}":
        command => "ln -sf ${stackhead::letsencrypt_certificate_dir}/fullchain_snakeoil.pem ${chain_path}",
        path    => '/bin',
      }
      exec { "real_key-${name}":
        command => "ln -sf ${stackhead::letsencrypt_certificate_dir}/privkey_snakeoil.pem ${privkey_path}",
        path    => '/bin',
      }
    }
  }
}