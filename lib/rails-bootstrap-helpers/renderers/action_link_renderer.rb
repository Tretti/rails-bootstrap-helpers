module RailsBootstrapHelpers::Renderers
  class ActionLinkRenderer < AbstractLinkRenderer
    def initialize (template, *args, &block)
      super template, :link, *args, &block
    end

    def render
      append_class "act"

      if style = has_option?("style")
        unless style.to_s == "default"
          append_class "act-" + style.to_s
        end
      end

      super
    end
  end
end