import gleam/bytes_builder
import gleam/http/response.{Response}
import mist

pub fn redirect_to(path: String) {
  Response(
    308,
    [#("Location", path)],
    "" |> bytes_builder.from_string |> mist.Bytes,
  )
}
