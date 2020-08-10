data "aws_route53_zone" "kammana" {
  name         = "kammana.tk."
  private_zone = false
}
# Add load balancer to the zone
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.kammana.zone_id
  name    = "kammana.tk."
  type    = "A"

  alias {
    name                   = aws_elb.myapp.dns_name
    zone_id                = aws_elb.myapp.zone_id
    evaluate_target_health = true
  }
}