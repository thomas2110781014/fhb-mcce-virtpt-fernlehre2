module "web-1" {
  source = "./modules/web"
  web_name = "first"
  backend1_name = "first"
  backend2_name = "first"
  desired_instances = "3"
  max_instances = "3"
  min_instances = "3"
  container_image = "nginx"
  container_image_version = "alpine"
}

# module "web-2" {
#   source = "./modules/web"
#   web_name = "second"
#   backend1_name = "second"
#   backend2_name = "second"
#   desired_instances = "3"
#   max_instances = "3"
#   min_instances = "3"
#   container_image = "nginx"
#   container_image_version = "alpine"
# }

output "first-url" {
  value = module.web-1.web-url
}

# output "second-url" {
#   value = module.web-2.web-url
# }
