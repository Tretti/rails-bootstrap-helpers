module RailsBootstrapHelpers::Renderers
  class IconicIconRenderer < Renderer
    def initialize (template, icon, options)
      super template
      @icon = icon
      @options = options.dup
    end

    def render
      icon = ERB::Util.html_escape(@icon.to_s)
      append_class!(options, "iconic-#{icon}")
      append_style(:color, options.delete(:color))
      
      handle_size
      handle_bs_style
      handle_action_style

      content_tag :i, "", bs_options(options)
    end

  private

    attr_reader :icon
    attr_reader :options

    def handle_bs_style
      if bs_style = options.delete(:bs_style)
        if bs_style.to_s == "muted"
          append_class!(options, :muted)
        else
          append_class!(options, "text-#{bs_style}")
        end
      end
    end

    def handle_action_style
      if action_style = options.delete(:action_style)
        append_class!(options, "act")

        unless action_style.to_s == "default"
          append_class!(options, "act-#{action_style}")
        end
      end
    end

    def handle_size
      if size = options.delete(:size)
        size = size.to_s

        if size.to_i > 0
          size << "px"
        end

        append_style("font-size", size)
      end
    end

    def append_style (key, value)
      if value
        style = options[:style].to_s

        if style.present?
          unless style.end_with?(";")
            style << ";"
          end

          style << " "
        end

        style << "#{key}: #{value};"
        options[:style] = style
      end
    end
  end
end