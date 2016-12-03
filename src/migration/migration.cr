require "../models/*"

Topaz::Db.setup("sqlite3://./db/sample.db")

Tweet.drop_table
Tweet.create_table
