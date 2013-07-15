module RailsBootstrapHelpers::Helpers::UrlHelper
  # Renders a Jasny Bootstrap action link. This method behaves just as "link_to"
  # but will render a Jasny Bootstrap action link instead of a regular link.
  # In addition to the options "link_to" handles, this method also handles the
  # following options:
  #
  # ==== Options
  # @param :style [String, Symbol] the style of the link
  def action_link_to (*args, &block)
    RailsBootstrapHelpers::Renderers::ActionLinkRenderer.new(self, *args, &block).render
  end

  # Renders a Jasny Bootstrap row link. This method behaves just as "link_to"
  # but will render a Jasny Bootstrap row link instead of a regular link.
  def row_link_to (*args, &block)
    RailsBootstrapHelpers::Renderers::RowLinkRenderer.new(self, *args, &block).render
  end
end