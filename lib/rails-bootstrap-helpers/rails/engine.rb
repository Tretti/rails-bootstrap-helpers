module RailsBootstrapHelpers
  module Rails
    class Engine < ::Rails::Engine
      initializer "rails-bootstrap-helpers.helpers" do
        ActionView::Base.send :include, RailsBootstrapHelpers::Helpers::AccordionHelper
        ActionView::Base.send :include, RailsBootstrapHelpers::Helpers::UrlHelper
        ActionView::Base.send :include, RailsBootstrapHelpers::Helpers::AlertHelper
        ActionView::Base.send :include, RailsBootstrapHelpers::Helpers::BaseHelper
        ActionView::Base.send :include, RailsBootstrapHelpers::Helpers::ButtonHelper
        ActionView::Base.send :include, RailsBootstrapHelpers::Helpers::FormTagHelper
        ActionView::Base.send :include, RailsBootstrapHelpers::Helpers::LabelHelper
        ActionView::Base.send :include, RailsBootstrapHelpers::Helpers::TagHelper
      end
    end
  end
end