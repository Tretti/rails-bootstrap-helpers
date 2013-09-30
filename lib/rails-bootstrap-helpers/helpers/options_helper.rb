module RailsBootstrapHelpers::Helpers::OptionsHelper
  # Handles general Bootstrap options available for all Bootstrap helpers.
  #
  # Any option not specify below are kept intact.
  #
  # @param options [Hash] a hash of options
  # @param html_options [Hash] a hash of HTML options/attributes
  #
  # @option option [String] :tooltip the text of the tooltip. If present adds attributes
  #        for a Bootstrap tooltip. This will add the <tt>data-toggle="tooltip"</tt>
  #        and <tt>title="#{tooltip}" </tt> HTML attributes if not already present
  #
  # @option options ["left", "right", "top", "bottom"] :tooltip_location the position of
  #        the tooltip if <tt>:tooltip</tt> is present. Adds the
  #        <tt>data-placement="#{tooltip_position}"</tt> HTML attribute if not
  #        already present.
  def bs_options (options, html_options = {})
    options = options.reverse_merge(html_options)

    if tooltip = options.delete(:tooltip)
      options[:"data-toggle"] ||= "tooltip"
      options[:title] ||= tooltip

      if tooltip_position = options.delete(:tooltip_position)
        options[:"data-placement"] ||= tooltip_position
      end
    end

    options
  end

  # Appends the given classes on the given options hash.
  #
  # It will look for both the "class" and :class key. This will create a new
  # :class key in the given hash if neither exist.
  #
  # @param options [Hash] hash of options to append the classes to
  # @param new_classes [Array<String>] the classes to append
  # @return options
  def append_class! (options, *new_classes)
    return options if new_classes.empty?
    key = options.key?("class") ? "class" : :class
    cls = options[key].to_s || ""

    if cls.present? && new_classes.first.present?
      cls << " "
    end

    cls << new_classes.join(" ")
    options[key] = cls
    options
  end
end