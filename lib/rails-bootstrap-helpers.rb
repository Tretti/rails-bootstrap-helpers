require "rails-bootstrap-helpers/core_ext/abstract"

module RailsBootstrapHelpers
  module Renderers
    autoload :AbstractButtonRenderer, "rails-bootstrap-helpers/renderers/abstract_button_renderer"
    autoload :AccordionRenderer, "rails-bootstrap-helpers/renderers/accordion_renderer"
    autoload :ButtonRenderer, "rails-bootstrap-helpers/renderers/button_renderer"
    autoload :ContentTagRenderer, "rails-bootstrap-helpers/renderers/content_tag_renderer"
    autoload :Renderer, "rails-bootstrap-helpers/renderers/renderer"
  end

  module Helpers
    autoload :AccordionHelper, "rails-bootstrap-helpers/helpers/accordion_helper"
    autoload :AlertHelper, "rails-bootstrap-helpers/helpers/alert_helper"
    autoload :BaseHelper, "rails-bootstrap-helpers/helpers/base_helper"
    autoload :ButtonHelper, "rails-bootstrap-helpers/helpers/button_helper"
    autoload :FormTagHelper, "rails-bootstrap-helpers/helpers/form_tag_helper"
    autoload :LabelHelper, "rails-bootstrap-helpers/helpers/label_helper"
    autoload :OptionsHelper, "rails-bootstrap-helpers/helpers/options_helper"
    autoload :TagHelper, "rails-bootstrap-helpers/helpers/tag_helper"
  end
end

require "rails-bootstrap-helpers/rails/engine"