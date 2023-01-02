# ДНС и ресурсные записи
resource "yandex_dns_zone" "zone1" {
  name        = "public-zone"
  zone        = "quoterback.ru."
  public      = true
}
resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "www.quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
resource "yandex_dns_recordset" "rs3" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "gitlab.quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
resource "yandex_dns_recordset" "rs4" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "alertmanager.quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
resource "yandex_dns_recordset" "rs5" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "grafana.quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
resource "yandex_dns_recordset" "rs6" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "prometheus.quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
resource "yandex_dns_recordset" "rs7" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "elasticsearch.quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
resource "yandex_dns_recordset" "rs8" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "logstash.quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
resource "yandex_dns_recordset" "rs9" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "kibana.quoterback.ru."
  type    = "A"
  ttl     = 200
  data    = [var.external_ip]
}
