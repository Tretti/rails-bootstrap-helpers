module RailsBootstrapHelpers::Renderers
  class Renderer
    abstract :render
    attr_reader :template

    def initialize (template)
      @template = template
    end

    def method_missing (*args, &block)
      @template.send(*args, &block)
    end
  end
end