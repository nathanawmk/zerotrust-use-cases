
resource "aws_acm_certificate" "default" {
  domain_name       = var.domainName
  validation_method = "DNS"
  tags = {
    yor_trace = "5b1b3844-06ab-4163-9cf0-f47d3e1deaa0"
  }
}

data "aws_route53_zone" "external" {
  name = var.dnsZone
}
resource "aws_route53_record" "validation" {
  name    = "${aws_acm_certificate.default.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.default.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  records = ["${aws_acm_certificate.default.domain_validation_options.0.resource_record_value}"]
  ttl     = "60"
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = "${aws_acm_certificate.default.arn}"
  validation_record_fqdns = [
    "${aws_route53_record.validation.fqdn}",
  ]
}





