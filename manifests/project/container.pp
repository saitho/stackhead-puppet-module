define stackhead::project::container (
  Array $domains,
  Array $services,
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $use_ssl = true,
  String $basicauth_title = 'Restricted area',
) {
  stackhead::nginx { $name:
    type            => 'container',
    domains         => $domains,
    ensure          => $ensure,
    use_ssl         => $use_ssl,
    basicauth_title => $basicauth_title
  }

  # Docker

  if $use_ssl {
    stackhead::ssl { $name:
      domains => $domains,
      ensure => $ensure
    }
  }
}