module RailsBootstrapHelpers::Helpers::TagHelper
  # Returns an HTML block tag. Properly adds indentation and newlines for the
  # returned HTML.
  #
  # ==== Example
  #   bs_content_tag "div", id: "foo" do
  #     bs_content_tag "div"
  #       append "foo"
  #     end
  #
  #     append "bar"
  #   end 
  #
  # <div id="foo">
  #   <div>
  #     foo
  #   </div>
  #   bar
  # </div>
  #
  # @param [String] the name of the tag to render
  # @param [Hash] a hash of HTML attributes
  def bs_content_tag (name, options = {}, &block)
    RailsBootstrapHelpers::Renderers::ContentTagRenderer.new(self, name, options, &block).render
  end
end