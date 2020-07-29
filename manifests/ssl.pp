define stackhead::ssl (
  Array $domains,
  Enum['present', 'absent'] $ensure,
) {
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
  notice("Setting up SSL certificate for domains '${join($domain_names, ",")}'")
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