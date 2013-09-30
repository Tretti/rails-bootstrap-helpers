module RailsBootstrapHelpers::Helpers::NavigationHelper
  include RailsBootstrapHelpers::Helpers::OptionsHelper

  # Renders a Bootstrap tabbable navigation.
  #
  # @param args [Array<String>, Hash] an array of the names of the tab items.
  #        If the last item is a Hash it's considered to be the options.
  #
  # @option options [Boolean] :bordered (false) if true, will render the tab
  #         container with a border. This option requires the Jasny Bootstrap extensions.
  #
  # @option option [Bootstrap] :fade (false) if true, will add the "fade in"
  #         class to all tab panes. This requires the bootstrap-transition.js file.
  def tabbable (*args, &block)
    RailsBootstrapHelpers::Renderers::TabbableRenderer.new(self, *args, &block).render
  end
end