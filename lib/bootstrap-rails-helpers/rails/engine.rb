#require "action"

module BootstrapRailsHelpers
  module Rails
    class Engine < ::Rails::Engine
      initializer "bootstrap-rails-helpers.helpers" do
        ActionView::Base.send :include, BootstrapRailsHelpers::Helpers::AlertHelper
        ActionView::Base.send :include, BootstrapRailsHelpers::Helpers::BaseHelper
        ActionView::Base.send :include, BootstrapRailsHelpers::Helpers::ButtonHelper
        ActionView::Base.send :include, BootstrapRailsHelpers::Helpers::FormTagHelper
        ActionView::Base.send :include, BootstrapRailsHelpers::Helpers::LabelHelper
      end
    end
  end
end