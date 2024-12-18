import decode
import gleam/io
import glenv

pub type Envs {
  Envs(
    database_url: String,
    database_user: String,
    database_password: String,
    database_name: String,
    stage: String,
  )
}

pub fn load_envs() {
  let definitions = [
    #("DATABASE_URL", glenv.String),
    #("DATABASE_USER", glenv.String),
    #("DATABASE_PASSWORD", glenv.String),
    #("DATABASE_NAME", glenv.String),
    #("STAGE", glenv.String),
  ]

  let decoder =
    decode.into({
      use database_url <- decode.parameter
      use database_user <- decode.parameter
      use database_password <- decode.parameter
      use database_name <- decode.parameter
      use stage <- decode.parameter

      Envs(
        database_url: database_url,
        database_user: database_user,
        database_password: database_password,
        database_name: database_name,
        stage: stage,
      )
    })
    |> decode.field("DATABASE_URL", decode.string)
    |> decode.field("DATABASE_USER", decode.string)
    |> decode.field("DATABASE_PASSWORD", decode.string)
    |> decode.field("DATABASE_NAME", decode.string)
    |> decode.field("STAGE", decode.string)

  let env = glenv.load(decoder, definitions)
  case env {
    Ok(parsed_envs) -> parsed_envs
    Error(err) -> {
      io.debug(err)
      Envs("database error", "meme", "pass", "name", "stage error")
    }
  }
}
