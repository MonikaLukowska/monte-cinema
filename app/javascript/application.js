// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

//prevent Turbo from being load twice
if (!window.Turbo) {
  require("@hotwired/turbo-rails")
}
