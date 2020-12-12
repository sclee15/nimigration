# Nimigration

A Nim DB Schema Migration based on Allographer

## Example

```nim
import "nimigration"

migration Migration001:
  schema([
    table("yo1", [
      Column().increments("id"),
      Column().string("name"),
      Column().foreign("auth_id").reference("id").on("auth").onDelete(SET_NULL)
    ])
  ]),
  

let migrations = @[
  Migration001()
]

migrate(migrations)
```