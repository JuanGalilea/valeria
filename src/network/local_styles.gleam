import gleam/bytes_builder
import gleam/http/response.{Response}
import mist
import simplifile

pub fn serve_styles(path: String) {
  let style = simplifile.read("./styles/" <> path <> "/index.css")
  case style {
    Ok(css_content) ->
      Response(
        200,
        [#("content-type", "text/css")],
        css_content |> bytes_builder.from_string |> mist.Bytes,
      )
    Error(_) -> Response(204, [], "" |> bytes_builder.from_string |> mist.Bytes)
  }
}
