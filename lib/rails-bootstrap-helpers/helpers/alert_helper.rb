# -*- encoding : utf-8 -*-

module RailsBootstrapHelpers::Helpers::AlertHelper
  # Renders a Bootstrap alert with the given text.
  #
  # @param text [String] the text to render in the alert
  #
  # ==== Options
  # @param :style [String] the style of alert to render
  # @param :block [Boolean] indicates if the alert should render with block style
  # @param :dismiss_button [Boolean] indicates if an dismiss button should be
  #        added to the alert
  def bs_alert (text, options = {})
    options = options.deep_dup
    cls = "alert"
    type = options.delete(:type)

    if type
      ActiveSupport::Deprecation.warn "Usage of the option `:type` is deprecated. Please use the `:style` option instead"
    end

    if style = options.delete(:style) || type
      style = style.to_s

      if style == "notice"
        style = "success"
      end

      unless style == "warning" || style == "default"
        cls << " alert-#{style}"
      end
    end

    if style = options.delete(:block)
      cls << " alert-block"
    end

    append_class!(options, cls)

    if options.delete(:dismiss_button)
      content_tag :div, class: cls do
        button = content_tag :button, "×",
          type: "button",
          class: "close",
          :"data-dismiss" => "alert"

        button + text
      end
    else
      content_tag :div, text, options
    end
  end
end