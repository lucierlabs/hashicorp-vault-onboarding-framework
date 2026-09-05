output "aliases" {
  value = {
    for row in local.output_list : row.map_key => row
  }
}

output "admin_aliases" {
  value = {
    for row in local.admin_output_list : row.map_key => row
  }
}
