module RailsBootstrapHelpers::Renderers
  class RowLinkRenderer < AbstractLinkRenderer
    def initialize (template, *args, &block)
      super template, :link, *args, &block
    end

    def render
      append_class "rowlink"
      super
    end
  end
end