switch("path", "$projectDir/../src")

import os

putEnv("DB_DRIVER", "sqlite")
putEnv("DB_CONNECTION", "test.sqlite3")
putEnv("DB_USER", "")
putEnv("DB_PASSWORD", "")
putEnv("DB_DATABASE", "")
putEnv("DB_MAX_CONNECTION", "95")

# Logging
putEnv("LOG_IS_DISPLAY", "true")
putEnv("LOG_IS_FILE", "true")
putEnv("LOG_DIR", "logs")