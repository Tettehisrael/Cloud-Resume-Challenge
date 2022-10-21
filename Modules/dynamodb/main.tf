resource "aws_dynamodb_table" "dynamo-table" {
  name           = "dynamo-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"
  billing_mode   = "PROVISIONED"

  attribute {
    name = "id"
    type = "N"
  }

  global_secondary_index {
  
    name            = "idIndex"
    hash_key        = "id"
    write_capacity  = 1
    read_capacity   = 1
    projection_type = "KEYS_ONLY"
  }
}

resource "aws_dynamodb_table_item" "table-item" {
  table_name = aws_dynamodb_table.dynamo-table.name
  hash_key   = aws_dynamodb_table.dynamo-table.hash_key

  item = <<ITEM
{
  "id": {"N": "0"},
  "visitcount": {"N": "0"}
}
ITEM
  # item = "${file("templates/item-table.json")}"
}

