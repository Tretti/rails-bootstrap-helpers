module BootstrapRailsHelpers::Helpers::FormTagHelper
  # Renders a Bootstrap button tag. This method behaves just as
  # <tt>button_tag</tt> but will render a Bootstrap styled button tag instead.
  #
  # @params text [String] the text of the button
  # @params type [String, Symbol] the type of the button. Adds a "type"
  #         attribute to the tag
  #
  # @params options [Hash] a hash of options
  #
  # ==== Options
  # @param :style [String, Symbol] the style of the button
  # @param :size ["large", "small", "mini"] the size of the button
  # @param :disabled [Boolean] if the button should be disabled or not
  # @param :icon [String] the name of an icon to render on the button
  # @param :icon_position ["left", "right"] the post of the icon, if present
  # @param :icon_invert [Boolean] if the color of the icon should be inverted
  def bs_button_tag (value, type, options = {})
    options = options.merge type: type
    BootstrapRailsHelpers::Renderers::ButtonRenderer.new(self, :button, value, options).render
  end
end