import json
import allographer/schema_builder
import allographer/query_builder

type
  Migration* = ref object of RootObj

method up(this: Migration) {.base.} =
  echo "up migration"
method down(this: Migration) {.base.} =
  echo "down migration"
method name(this: Migration): string {.base.} =
  raise newException(OSError, "No name specified")

proc migrate*(migrations: seq) = 
  schema([
    table("migrations", [
      Column().increments("id"),
      Column().string("name")
    ])
  ])

  for m in migrations:
    let migration_name = $(m.name)
    let executed = rdb()
      .table("migrations")
      .select("id", "name")
      .where("name", "=", migration_name)
      .orderBy("id", Order.Asc)
      .first()
    if executed.kind == JNull:
      echo "up"
      echo migration_name
      m.up()
      rdb().table("migrations").insert(%*{"name": migration_name})
    else:
      echo "pass"
      echo migration_name

template migration*(migration_name: untyped, u: untyped): untyped =
  type
    migration_name* = ref object of Migration
    
  method name*(this: migration_name): string = $migration_name

  method up*(this: migration_name) =
    u

template migration*(migration_name: untyped, u: untyped, d: untyped): untyped =
  type
    migration_name* = ref object of Migration
    
  method name*(this: migration_name): string = $migration_name

  method up*(this: migration_name): void =
    u
  
  method down*(this: migration_name): void =
    d