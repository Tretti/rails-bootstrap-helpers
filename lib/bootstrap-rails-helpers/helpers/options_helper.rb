module BootstrapRailsHelpers::Helpers::OptionsHelper
  # Handles general Bootstrap options available for all Bootstrap helpers.
  #
  # Any option not specify below are kept intact.
  #
  # @param options [Hash] a hash of options
  # @param html_options [Hash] a hash of HTML options/attributes
  #
  # ==== Options
  # @param :tooltip [String] the text of the tooltip. IF present adds attributes
  #        for a Bootstrap tooltip. This will add the <tt>data-toggle="tooltip"</tt>
  #        and <tt>title="#{tooltip}" </tt> HTML attributes if not already present
  #
  # @param :tooltip_location ["left", "right", "top", "bottom"] the position of
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
end