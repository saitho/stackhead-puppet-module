define stackhead::nginx::ssl_proxy (
  $ssl_cert,
  $ssl_key,
  $proxy_port,
  $listen_port = 80,
  $server_name = $name,
) {
  include nginx

  nginx::resource::server { "${name}":
    ensure          => present,
    server_name     => ["${server_name}"],
    ssl             => true,
    ssl_cert        => "${ssl_cert}",
    ssl_key         => "${ssl_key}",
    ssl_redirect    => true,
    proxy           => "http://127.0.0.1:${proxy_port}",
  }
}