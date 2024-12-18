import gleam/http/request.{type Request}
import gleam/http/response.{type Response, Response}
import mist.{type Connection, type ResponseData}
import nakai/attr as a
import nakai/html as h
import render

pub fn page(_req: Request(Connection)) -> Response(ResponseData) {
  let body =
    h.div([a.class("notFoundContainer")], [
      h.img([a.src("https://gleam.run/images/lucy/lucy.svg")]),
      h.h1_text([], "404"),
      h.h2_text([], "No encontrado"),
      h.link([a.rel("stylesheet"), a.href("/styles/notfound")]),
    ])
  render.render_404(body)
}
