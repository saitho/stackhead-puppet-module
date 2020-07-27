# @summary
#   Wrapper package for Puppet configurations
#
# @example
#   class { 'stackhead': }
#
class stackhead (
  String $certificate_dir,
  String $certificate_email,
  String $acme_dir,
  String $project_certificate_dir,
  String $htpasswd_path,
) {

}