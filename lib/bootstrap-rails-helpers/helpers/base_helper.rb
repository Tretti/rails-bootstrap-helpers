module BootstrapRailsHelpers::Helpers
  module BaseHelper
    # Renders the given icon
    #
    # Renders an <tt>i</tt> tag with the class "icon-#{icon}"
    #
    # @param icon [String, Symbol] the kind of icon to render
    #
    # ==== Options
    # @param :invert [Boolean] if the color of the icon should be inverted
    def self.icon (icon, options = {})
      icon = ERB::Util.html_escape(icon.to_s)
      cls = "icon-" + icon

      if invert = options.delete(:invert)
        cls << " icon-white"
      end

      "<i class=\"#{cls}\"></i>".html_safe
    end

    # Renders the given icon
    #
    # Renders an <tt>i</tt> tag with the class "icon-#{icon}"
    #
    # @param icon [String, Symbol] the kind of icon to render
    #
    # ==== Options
    # @param :invert [Boolean] if the color of the icon should be inverted
    def icon (icon, options = {})
      BaseHelper.icon(icon, options)
    end
  end
end