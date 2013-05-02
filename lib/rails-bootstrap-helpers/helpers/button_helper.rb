module RailsBootstrapHelpers::Helpers::ButtonHelper
  # Renders a Bootstrap button. This method behaves just as "link_to" but will
  # render a Bootstrap button instead of a regular link. Note that this is still
  # an "a" tag and not an "input" tag. In addition to the options "link_to"
  # handles this method also handles the following options:
  #
  # ==== Options
  # @param :style [String, Symbol] the style of the button
  # @param :size ["large", "small", "mini"] the size of the button
  # @param :disabled [Boolean] if the button should be disabled or not
  # @param :icon [String] the name of an icon to render on the button
  # @param :icon_position ["left", "right"] the position of the icon, if present
  # @present :icon_invert [Boolean] if the color of the icon should be inverted
  #   or not
  def bs_button_to (*args, &block)
    RailsBootstrapHelpers::Renderers::ButtonRenderer.new(self, :link, *args, &block).render
  end

  # Renders an inline Bootstrap button. That is, a small button having only an
  # icon and no text.
  #
  # @param url [String] the URL the button should link to
  # @param icon [String] the icon of the button
  # @param options [Hash] a hash of options. See bs_button_to
  #
  # @see #bs_button_to
  def bs_inline_button_to (url, icon, options = {})
    options = options.reverse_merge icon: icon, size: "mini"
    RailsBootstrapHelpers::Renderers::ButtonRenderer.new(self, :link, nil, url, options).render
  end

  # Renders a Bootstrap button with a popover.
  #
  # @param name [String] the name/title of the button
  # @param content_or_options [String, Hash] a hash of options if a block is
  #        passed, otherwise the content of the popover
  #
  # @param block [block] a block rendering the content of the popover
  #
  # ==== Options
  # @param :placement [String, "bottom", "top", "left", "right"]
  #
  # @see #bs_button_to
  def bs_popover_button (name, content_or_options = nil, options = {}, &block)
    if block_given?
      bs_popover_button(name, capture(&block).gsub("\n", ""), content_or_options || {})
    else
      placement = options.delete(:position) || options.delete(:placement) || "bottom"

      options = options.reverse_merge :"data-content" => content_or_options,
        :"data-toggle" => "popover",
        :"data-placement" => placement

      bs_button_to(name, '#', options)
    end
  end

  # Renders a collapsible Bootstrap button. That is, a button when clicked opens
  # a collapsible section.
  #
  # @param text [String] the text of the button
  # @param target [String] a selector matching the
  # @param options [Hash] a hash of options. All options are passed straight
  #        through to the underlying bs_button_to method.
  #
  # @see #bs_button_to
  def bs_collapsible_button (text, target, options = {})
    options = options.dup.reverse_merge :"data-toggle" => "collapse",
      :"data-target" => target

    bs_button_tag text, :button, options
  end
end