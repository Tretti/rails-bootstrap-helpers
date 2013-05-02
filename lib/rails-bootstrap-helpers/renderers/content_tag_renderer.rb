module RailsBootstrapHelpers::Renderers
  class ContentTagRenderer < Renderer
    def initialize (template, name, options, &block)
      super template

      @name = name
      @options = options
      @block = block
      
      @indentation_level = 0
      @default_indentation = 2
      @buffer = ""
      @context = Context.new(self)
    end

    def render
      content_tag_impl(name, options, &block)
    end

  private

    attr_reader :name
    attr_reader :content
    attr_reader :options
    attr_reader :block
    attr_reader :context
    attr_reader :buffer
    attr_reader :default_indentation

    def content_tag_impl (name, options = {}, &block)
      append tag(name, options, true)
      indent { context.instance_eval(&block) }
      append "</#{name}>"
      buffer.html_safe
    end

    def indent (&block)
      last_indentation_level = @indentation_level
      @indentation_level += default_indentation
      block.call
    ensure
      @indentation_level = last_indentation_level
    end

    def append (string)
      unless string.nil?
        buffer << " " * @indentation_level
        buffer << string
        buffer << "\n"
      end
    end

    class Context
      def initialize (renderer)
        @renderer = renderer
      end

      def bs_content_tag (name, options = {}, &block)
        @renderer.send :content_tag_impl, name, options, &block
      end

      def append (string)
        @renderer.send :append, string
      end
    end
  end
end