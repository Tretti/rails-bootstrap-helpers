module RailsBootstrapHelpers::Helpers::BaseHelper
  include RailsBootstrapHelpers::Helpers::OptionsHelper

  # Renders the given icon
  #
  # Renders an <tt>i</tt> tag with the class "icon-#{icon}"
  #
  # @param icon [String, Symbol] the kind of icon to render
  #
  # ==== Options
  # @param :invert [Boolean] if the color of the icon should be inverted
  def self.icon (icon, options = {})

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
    #RailsBootstrapHelpers::Helpers::BaseHelper.icon(icon, options)
    options = options.dup

    icon = ERB::Util.html_escape(icon.to_s)
    append_class!(options, "icon-" + icon)

    if options.delete(:invert)
      append_class!(options, "icon-white")
    end

    cls = options[:class]

    "<i class=\"#{cls}\"></i>".html_safe
  end
end