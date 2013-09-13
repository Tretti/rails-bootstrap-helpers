module RailsBootstrapHelpers::Renderers
  class DropdownButtonRenderer < Renderer
    def initialize (template, text, url_or_options = nil, options = {}, &block)
      super template
      @text = text
      @block = block

      extract_args!(url_or_options, options)
    end

    def render
      button_group do
        render_toggle_button + "\n" +
        render_menu
      end
    end

  private
    attr_reader :options
    attr_reader :url
    attr_reader :split
    attr_reader :block
    attr_reader :text

    def extract_args! (url_or_options, options)
      if url_or_options.is_a?(Hash)
        @options = url_or_options.dup
        @split = false
      elsif url_or_options.nil?
        @options = options.dup
        @split = false
      else
        @url = url_or_options
        @options = options.dup
        @split = true
      end
    end

    def render_toggle_button
      if split
        bs_button_to(text, url, options) << "\n" <<
        render_toggle_button_impl(false)
      else
        render_toggle_button_impl(true)
      end
    end

    def toggle_options
      @toggle_options ||= begin
        opts = split ? {} : options.deep_dup
        data = opts[:data] || {}
        data[:toggle] = "dropdown"
        opts[:data] = data

        append_class!(opts, "dropdown-toggle")

        if (style = options[:style]) && style != "default"
          append_class!(opts, "btn-#{style}")
        end

        opts
      end
    end

    def render_caret
      content_tag :span, nil, class: "caret"
    end

    def render_toggle_button_impl (with_text)
      text = with_text ? text_with_caret : render_caret
      bs_button_tag text, nil, toggle_options
    end

    def text_with_caret
      @text_with_caret ||= begin
        escaped_text = ERB::Util.html_escape(text)
        (escaped_text + " " + render_caret).html_safe
      end
    end

    def render_menu
      content_tag :ul, class: "dropdown-menu" do
        template.capture(&block)
      end
    end
  end
end