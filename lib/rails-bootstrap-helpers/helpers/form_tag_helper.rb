module RailsBootstrapHelpers::Helpers::FormTagHelper
  # Renders a Bootstrap button tag. This method behaves just as
  # <tt>button_tag</tt> but will render a Bootstrap styled button tag instead.
  #
  # @params value [String] the text of the button
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
  def bs_button_tag (value, type, options = {}, &block)
    options = options.merge type: type
    RailsBootstrapHelpers::Renderers::ButtonRenderer.new(self, :button, value, options, &block).render
  end

  # Renders a Boolean submit tag. This method behaves just as
  # <tt>submit_tag</tt> but will render a Bootstrap styled submit tag instead.
  #
  # @param value [String] the text of the submit tag
  # @param options [Hash] a hash of options
  #
  # ==== Options
  # @param :style [String, Symbol] the style of the button
  # @param :size ["large", "small", "mini"] the size of the button
  #
  # All the other options are passed straight through to the underlying
  # <tt>submit_tag</tt> method.
  def bs_submit_tag (value, options = {})
    options = options.dup

    if options[:class].present?
      options[:class] << " "
    else
      options[:class] = ""
    end

    options[:class] << "btn"

    if style = options.delete(:style)
      options[:class] << " btn-" + style.to_s
    end

    if size = options.delete(:size)
      options[:class] << " btn-" + size.to_s
    end

    submit_tag value, options
  end
end