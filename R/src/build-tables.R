dotenv::load_dot_env(
  "/usr/.env"
)

con <- odbc::dbConnect(
  odbc::odbc(),
  Driver = "SQL Server",
  Server = "sql-container",
  Database = "dcyf_curated_replica",
  UID = "sa",
  PWD = Sys.getenv("SA_PASSWORD"),
  Port = 1433
)

odbc::dbWriteTable(
  conn = con,
  name = "iris",
  value = iris,
  overwrite = TRUE
)