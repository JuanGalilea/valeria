import context/env
import gleam/bytes_builder as bb
import gleam/erlang/process
import gleam/http/request.{type Request}
import gleam/http/response.{Response}
import gleam/io
import gleam/option
import gleam/pgo
import mist
import nakai
import nakai/attr.{type Attr}
import nakai/html.{type Node}
import network/local_styles
import network/redirect
import pages/home/index as home
import pages/notfound/index as notfound

const header_style = "
  color: #331f26;
  font-family: 'Neuton', serif;
  font-size: 128px;
  font-weight: 400;
"

fn header(attrs: List(Attr), text: String) -> Node {
  let attrs = [attr.style(header_style), ..attrs]
  html.h1_text(attrs, text)
}

fn render_page() -> String {
  html.Html([], [
    html.Head([
      html.title("Horas extra hospital chaiten"),
      html.Script([attr.src("https://unpkg.com/htmx.org@2.0.2")], ""),
    ]),
    html.Body([], [
      header([], "Hello, from Nakai!"),
      html.table([attr.style("border: 5px double black")], [
        html.tr([], [
          html.th([], [html.Text("lelito")]),
          html.th([], [html.Text("count")]),
          html.th([], [html.Text("action")]),
        ]),
        html.tr([], [
          html.td([], [html.Text("guaguitooo")]),
          html.td([], [html.Text("1")]),
          html.td([], [
            html.button(
              [attr.Attr("hx-post", "/lele"), attr.Attr("hx-swap", "innerHTML")],
              [html.Text("click me")],
            ),
          ]),
        ]),
      ]),
    ]),
  ])
  |> nakai.to_string()
}

pub fn main() {
  let envs = env.load_envs()

  let assert Ok(_) =
    web_service(envs)
    |> mist.new
    |> mist.port(8080)
    |> mist.start_http
  process.sleep_forever()
}

fn web_service(envs: env.Envs) {
  let db =
    pgo.connect(
      pgo.Config(
        ..pgo.default_config(),
        host: envs.database_url,
        user: envs.database_user,
        password: option.Some(envs.database_password),
        database: envs.database_name,
        pool_size: 15,
      ),
    )
  let sql =
    "
  select
    id
  from
    extra_hours"

  let lele = pgo.execute(sql, db, [], fn(a) { Ok(a) })
  io.debug(lele)

  fn(req: Request(mist.Connection)) {
    io.debug(req.path)
    io.debug(req.method)
    case req.path {
      "/styles" <> path -> local_styles.serve_styles(path)
      "/lele" -> {
        let body = bb.from_string(envs.stage)
        Response(200, [#("content-type", "text/html")], mist.Bytes(body))
      }
      "/home" -> home.page(req)
      "/home/action/" <> action -> home.actions(req, action)
      "/notfound" -> notfound.page(req)
      "" | "/" -> redirect.redirect_to("/home")
      _ -> redirect.redirect_to("/notfound")
    }
  }
}
