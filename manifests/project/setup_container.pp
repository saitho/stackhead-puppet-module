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

      $auth = ('security' in domain and 'authentication' in domain[security]) ? {
        true => domain[security][authentication],
        default => []
      }

      notice("Setting up Nginx for domain '${domain[domain]}' with port '${expose[external_port]}' on project '${name}'")
      stackhead::nginx::ssl_proxy { "${domain[domain]}-${expose[external_port]}":
        project_name    => $name,
        ensure          => $ensure,
        server_name     => $domain[domain],
        listen_port     => $expose[external_port],
        proxy_port      => $expose[internal_port],
        use_ssl         => $use_ssl,
        auth            => $auth,
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

    $chain_path = "${stackhead::project_certificate_dir}/fullchain.pem"
    $privkey_path = "${stackhead::project_certificate_dir}/privkey.pem"
    notice("Setting up SSL certificate for domains '${join($domain_names, ",")}' on project '${name}'")
    letsencrypt::certonly { $name:
      ensure               => $ensure,
      domains              => $domain_names,
      webroot_paths        => ["${stackhead::acme_dir}/${name}"],
      plugin               => 'webroot',
      deploy_hook_commands => [
        "ln -sf ${stackhead::letsencrypt_certificate_dir}/fullchain.pem ${chain_path}",
        "ln -sf ${stackhead::letsencrypt_certificate_dir}/privkey.pem ${privkey_path}"
      ]
    }
  }
}