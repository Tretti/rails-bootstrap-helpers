# -*- encoding : utf-8 -*-

module BootstrapRailsHelpers::Helpers::AlertHelper
  # Renders a Bootstrap alert with the given text.
  #
  # @param text [String] the text to render in the alert
  #
  # ==== Options
  # @param :type [String] the type of alert to render
  # @param :block [Boolean] indicates if the alert should render with block style
  # @param :dismiss_button [Boolean] indicates if an dismiss button should be
  #        added to the alert
  def bs_alert (text, options = {})
    cls = "alert"

    if type = options[:type]
      type = type.to_s

      if type == "notice"
        type = "success"
      end

      unless type == "warning" || type == "default"
        cls << " alert-#{type}"
      end
    end

    if type = options[:block]
      cls << " alert-block"
    end

    if dismiss_button = options[:dismiss_button]
      content_tag :div, class: cls do
        button = content_tag :button, "×",
          type: "button",
          class: "close",
          :"data-dismiss" => "alert"

        button + text
      end
    else
      content_tag :div, text, class: cls
    end
  end
end