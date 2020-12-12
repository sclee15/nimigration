import unittest
import nimigration

var upExcupted = false

migration Migration001:
  upExcupted = true
  schema([
    table("yo1", [
      Column().increments("id"),
      Column().string("name"),
      Column().foreign("auth_id").reference("id").on("auth").onDelete(SET_NULL)
    ])
  ])

test "migration won't happen twice":
  let migrations = @[
    Migration001()
  ]
  migrate(migrations)
  check(upExcupted == true)
  upExcupted = false
  migrate(migrations)
  check(upExcupted == false)
  # this is false because same migration will not gonna be executed again