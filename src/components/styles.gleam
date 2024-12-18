import nakai/attr
import nakai/html

pub fn stylesheet(path: String) {
  html.link([attr.rel("stylesheet"), attr.href(path)])
}
