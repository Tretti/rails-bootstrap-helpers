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

  # Renders the given Iconic icon.
  # 
  # This is the Iconic icons from Jasny Bootstrap.
  # Renders an <tt>i</tt> tag with the class "iconic-#{icon}"
  #
  # @param icon [String, Symbol] the kind of icon to render
  #
  # ==== Options
  # @param :color [String, Symbol] the CSS color of the icon
  # @param :size [String, Symbol, Number] the CSS font size of the icon
  #
  # @param :bs_style [:warning, :error, :info, :success, :muted]
  #         the Bootstrap style to render the icon in
  #
  # @param :action_style [:primary, :info, :success, :warning, :danger]
  #         renders the icon with this action link style
  def iconic_icon (icon, options = {})
    RailsBootstrapHelpers::Renderers::IconicIconRenderer.new(self, icon, options).render
  end
end