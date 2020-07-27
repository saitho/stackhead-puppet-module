define stackhead::project::setup_container (
  Array $domains,
  Array $services,
) {
  # project_name = ${name}

  # SSL certificates
  class { 'letsencrypt':
    config => {
      email  => $stackhead::certificate_email,
      server => 'https://acme-v02.api.letsencrypt.org/directory',
    },
    renew_cron_ensure => 'present',
  }

  # Setup Nginx configurations
  $domains.each |Hash $domain| {
    if (!domain['expose']) {
      next
    }
    $domain['expose'].each |Hash $expose| {
      stackhead::nginx::ssl_proxy { "${domain['domain']}-${expose['external_port']}":
        server_name => $domain['domain'],
        listen_port => $expose['external_port'],
        proxy_port => $expose['internal_port'],
      }
    }
  }

  # Generate real SSL certificates
  $domain_names = $domains.map |$item| { $item['domain'] }
  $acme_dirs = $domain_names.map |String $domain | {
    "${stackhead::acme_dir}/${domain}"
  }

  letsencrypt::certonly { "${name}":
    domains       => $domain_names,
    webroot_paths => $acme_dirs,
    plugin        => 'webroot',
  }
}