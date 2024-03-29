import gleam/int
import gleam/list
import lustre
import lustre/attribute
import lustre/effect
import lustre/element/html
import lustre/event

pub type Model {
  Model(id: Int, all: List(Int))
}

pub type Msg {
  Add
}

pub fn main() {
  let assert Ok(_) =
    fn(_) { #(Model(0, []), effect.none()) }
    |> lustre.application(update, view)
    |> lustre.start("#app", Nil)
}

fn update(model: Model, msg: Msg) {
  case msg {
    Add -> {
      let id = model.id + 1
      let all = [model.id, ..model.all]
      #(Model(id: id, all: all), effect.none())
    }
  }
}

fn view(model: Model) {
  html.div([attribute.style([#("padding", "12px")])], [
    html.button([event.on_click(Add)], [html.text("Test render")]),
    html.div([], list.map(model.all, render)),
  ])
}

fn render_styles() {
  attribute.style([
    #("animation", "5s fade"),
    #("border", "1px solid black"),
    #("border-radius", "10px"),
    #("padding", "12px"),
    #("margin", "12px 0"),
    #("max-width", "500px"),
  ])
}

fn render(id: Int) {
  html.div([render_styles()], [html.text(int.to_string(id))])
}
