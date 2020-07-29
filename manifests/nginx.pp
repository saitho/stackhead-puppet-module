define stackhead::nginx (
  Enum['container', 'native'] $type,
  Array $domains,
  Enum['present', 'absent'] $ensure,
  Boolean $use_ssl,
  String $basicauth_title,
) {
  $domains.each |Hash $domain| {
    $domain[expose].each |Integer $index, Hash $expose| {
      $auth = ('security' in domain and 'authentication' in domain[security]) ? {
        true => domain[security][authentication],
        default => []
      }

      if $type == 'container' {
        notice("Setting up Reverse Proxy Nginx for domain '${domain[domain]}' with port '${expose[external_port]}'")
        stackhead::nginx::proxy { "${domain[domain]}-${expose[external_port]}":
          project_name    => $name,
          ensure          => $ensure,
          server_name     => $domain[domain],
          listen_port     => $expose[external_port],
          proxy_port      => $expose[internal_port],
          use_ssl         => $use_ssl,
          auth            => $auth,
          basicauth_title => $basicauth_title,
        }
      } else {
        notice("Setting up regular Nginx for domain '${domain[domain]}' with port '${expose[external_port]}'")
        # todo
      }
    }
  }
}