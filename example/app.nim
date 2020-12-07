import "../src/nimigration"
import "migrations/migration001"

let migrations = @[
  Migration001()
]
migrate(migrations)