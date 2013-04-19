require "bootstrap-rails-helpers/core_ext/abstract"

module BootstrapRailsHelpers
  module Renderers
    autoload :Renderer, "bootstrap-rails-helpers/renderers/renderer"
    autoload :AbstractButtonRenderer, "bootstrap-rails-helpers/renderers/abstract_button_renderer"
    autoload :ButtonRenderer, "bootstrap-rails-helpers/renderers/button_renderer"
  end

  module Helpers
    autoload :BaseHelper, "bootstrap-rails-helpers/helpers/base_helper"
    autoload :ButtonHelper, "bootstrap-rails-helpers/helpers/button_helper"
  end
end