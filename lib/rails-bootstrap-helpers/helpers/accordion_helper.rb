module RailsBootstrapHelpers::Helpers::AccordionHelper
  # Renders a Bootstrap accordion.
  #
  # @param [String] an ID that is unique for the page
  def accordion (id, &block)
    RailsBootstrapHelpers::Renderers::AccordionRenderer.new(self, id, &block).render
  end
end