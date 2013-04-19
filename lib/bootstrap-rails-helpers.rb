require "bootstrap-rails-helpers/core_ext/abstract"

module BootstrapRailsHelpers
  module Renderers
    autoload :AbstractButtonRenderer, "bootstrap-rails-helpers/renderers/abstract_button_renderer"
    autoload :ButtonRenderer, "bootstrap-rails-helpers/renderers/button_renderer"
    autoload :Renderer, "bootstrap-rails-helpers/renderers/renderer"
  end

  module Helpers
    autoload :AlertHelper, "bootstrap-rails-helpers/helpers/alert_helper"
    autoload :BaseHelper, "bootstrap-rails-helpers/helpers/base_helper"
    autoload :ButtonHelper, "bootstrap-rails-helpers/helpers/button_helper"
    autoload :FormTagHelper, "bootstrap-rails-helpers/helpers/form_tag_helper"
    autoload :LabelHelper, "bootstrap-rails-helpers/helpers/label_helper"
    autoload :OptionsHelper, "bootstrap-rails-helpers/helpers/options_helper"
  end
end

require "bootstrap-rails-helpers/rails/engine"