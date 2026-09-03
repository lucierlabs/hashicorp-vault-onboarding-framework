output "aliases" {
  value = {
    for row in local.output_list : row.map_key => row
  }
}
