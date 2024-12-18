import components/styles
import gleam/bytes_builder
import mist
import nakai
import nakai/attr
import nakai/html.{type Node}

pub fn render_page(page: Node) {
  html.Html([], [
    html.Head([
      html.title("Horas extra hospital chaiten"),
      html.Script([attr.src("https://unpkg.com/htmx.org@2.0.2")], ""),
      styles.stylesheet("/styles"),
    ]),
    html.Body([], [page_layout(page)]),
  ])
  |> nakai.to_string()
  |> bytes_builder.from_string()
  |> mist.Bytes()
}

pub fn page_layout(content: Node) {
  html.div([], [
    html.div([attr.style("width: 100%; height: 10dvh")], []),
    content,
  ])
}
