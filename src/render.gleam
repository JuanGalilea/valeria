import components/layout
import gleam/bytes_builder.{from_string}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response, Response}
import mist.{type Connection, type ResponseData}
import nakai.{to_string}
import nakai/html.{type Node}

fn to_html(status: Int, data: ResponseData) -> Response(ResponseData) {
  Response(status, [#("content-type", "text/html")], data)
}

fn to_html_ok(data: ResponseData) -> Response(ResponseData) {
  to_html(200, data)
}

fn to_html_404(data: ResponseData) -> Response(ResponseData) {
  to_html(404, data)
}

pub fn render_ok(page: Node) -> Response(ResponseData) {
  page |> layout.render_page |> to_html_ok
}

pub fn render_404(page: Node) -> Response(ResponseData) {
  page |> layout.render_page |> to_html_404
}

pub fn render_component(component: Node) -> String {
  to_string(component)
}

pub fn render_ok_component(component: Node) {
  component |> to_string |> from_string |> mist.Bytes |> to_html_ok
}
