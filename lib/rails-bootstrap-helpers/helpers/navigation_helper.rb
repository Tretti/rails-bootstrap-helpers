module RailsBootstrapHelpers::Helpers::NavigationHelper
  # Renders a Bootstrap tabbable navigation.
  #
  # @param args [Array<String>, Hash] an array of the names of the tab items.
  #        If the last item is a Hash it's considered to be the options.
  #
  # ==== Options
  # @param :bordered [Boolean] if true, will render the tab container with a
  #        border. This option requires the Jasny Bootstrap extensions.
  def tabbable (*args, &block)
    RailsBootstrapHelpers::Renderers::TabbableRenderer.new(self, *args, &block).render
  end
end