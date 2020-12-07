import allographer/schema_builder
import "../../src/nimigration.nim"

migration Migration001,
  u =
    schema([
      table("yo1", [
        Column().increments("id"),
        Column().string("name"),
        Column().foreign("auth_id").reference("id").on("auth").onDelete(SET_NULL)
      ])
    ]),
  d =
    echo "down"