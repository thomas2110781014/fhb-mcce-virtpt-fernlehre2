module "web-1" {
  source = "./modules/web"
  web_name = "first"
  desired_instances = "2"
  max_instances = "2"
  min_instances = "2"
  container_image = "nginx"
  container_image_version = "alpine"
}

module "web-2" {
  source = "./modules/web"
  web_name = "second"
  desired_instances = "2"
  max_instances = "2"
  min_instances = "2"
  container_image = "nginx"
  container_image_version = "alpine"
}

output "first-url" {
  value = module.web-1.web-url
}

output "second-url" {
  value = module.web-2.web-url
}
