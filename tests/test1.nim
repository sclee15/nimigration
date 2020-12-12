import unittest
import nimigration

var upExcupted = false

migration Migration001:
  upExcupted = true

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