module RailsBootstrapHelpers::Renderers
  class AbstractLinkRenderer < Renderer
    def initialize (template, type, *args, &block)
      super template
      @args = args
      @block = block
      @text = self.args[0]
      @type = type

      extract_options!
    end

    def render
      template.send method, *new_args, &block
    end

  protected

    attr_reader :block
    attr_reader :args

    attr_accessor :options
    attr_accessor :html_options
    attr_accessor :text
    attr_accessor :type

    def method
      case type
        when :link then :link_to
        when :button then :button_tag
        else :link_to
      end
    end

    def new_args
      case type
        when :link
          [text, options, html_options, *self.args[3 .. -1]]
        when :button then
          opts = options.reverse_merge(html_options)
          [text, opts, *self.args[3 .. -1]]
        else
          [text, options, html_options, *self.args[3 .. -1]]
      end    
    end

    # Returns true if the given key exists as an option.
    #
    # @param key [String, Symbol] the key to check for
    # @return the value of the option
    def has_option? (key)
      _has_option?(key, options, html_options)
    end

    # Appends the given class to the "class" HTMl attribute.
    #
    # @param cls [String, Symbol] the class to append
    def append_class (cls)
      return unless cls

      if c = html_options["class"]
        html_options["class"] << " " + cls.to_s
      else
        if c = has_option?("class")
          c << " " + cls.to_s
          cls = c
        end

        html_options["class"] = cls.to_s
      end
    end

  private

    def extract_options!
      self.options = args[1]

      if options.is_a?(Hash)
        self.options = bs_options(options)
        self.options = options.stringify_keys
      end

      self.html_options = args[2] || {}
      self.html_options = bs_options(html_options)
      self.html_options = html_options.stringify_keys

      if cls = html_options["class"]
        html_options["class"] = cls.dup
      end
    end

    def _has_option? (key, options, html_options = nil)
      result = options.is_a?(Hash) && options.key?(key) && options.delete(key)

      if html_options
        result || _has_option?(key, html_options)
      else
        result
      end
    end
  end
end