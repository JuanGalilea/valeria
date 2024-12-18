import gleam/http/request.{type Request}
import gleam/list
import mist.{type Connection}
import nakai/attr as a
import nakai/html as h
import render

pub fn page(_req: Request(Connection)) {
  let months = [
    "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto",
    "Septiembre", "Octubre", "Noviembre", "Diciembre",
  ]
  let body =
    h.div([], [
      h.link([a.rel("stylesheet"), a.href("/styles/home")]),
      h.div([a.class("overtimeWrapper")], [
        h.div(
          [a.class("monthPicker")],
          list.map(months, fn(month: String) {
            h.div(
              [
                a.class("month"),
                a.Attr("hx-get", "/home/action/" <> month),
                // a.Attr("hx-get", "/lele"),
                a.Attr("hx-target", "#monthData"),
                a.Attr("hx-swap", "innerHTML"),
              ],
              [h.Text(month)],
            )
          }),
        ),
        h.div([a.class("monthData"), a.id("monthData")], [h.Text("meme")]),
      ]),
    ])

  render.render_ok(body)
}

pub fn actions(_req, action: String) {
  let res = h.Text(action)
  render.render_ok_component(res)
}
