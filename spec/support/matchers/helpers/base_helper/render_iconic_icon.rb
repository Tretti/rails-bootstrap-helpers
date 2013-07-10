RSpec::Matchers.define :render_iconic_icon do |icon|
  def options
    @options ||= {  }
  end

  def icon
    @icon
  end

  def cls
    @cls ||= begin
      "iconic-#{icon}".tap do |cls|
        cls << bs_style_class
        cls << action_style_class
      end
    end
  end

  def bs_style_class
    if bs_style = options[:bs_style]
      if bs_style.to_s == "muted"
        " muted"
      else
        " text-#{bs_style}"
      end
    else
      ""
    end
  end

  def action_style_class
    if action_style = options[:action_style]
      " act".tap do |cls|
        unless action_style.to_s == "default"
          cls << " act-#{action_style}"
        end
      end
    else
      ""
    end
  end

  def append_style (key, value)
    if value
      @style ||= ""

      unless @style.end_with?(";")
        @style << ";"
      end

      @style << " "

      @style << "#{key}: #{value};"
    end
  end

  def handle_size
    if size = options[:size]
      size = size.to_s

      if size.to_i > 0
        size << "px"
      end

      append_style("font-size", size)
    end
  end

  def html_attributes
    handle_size

    if color = options[:color]
      append_style(:color, color)
    end

    attrs = { class: cls }
    attrs[:style] = @style if @style.present?

    if tooltip?
      if tooltip_position?
        attrs[:"data-placement"] = options[:tooltip_position]
      end

      attrs[:"data-toggle"] = "tooltip"
      attrs[:title] = options[:tooltip]
    end

    attrs.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
  end

  def expected
    @render_icon_expected ||= "<i #{html_attributes}></i>"
  end

  def got
    @got ||= helper.iconic_icon(icon, options)
  end

  def failure_message (is_not)
    ex = is_not ? "expected not" : "expected"
    "#{ex}: #{expected}\n     got: #{got}"
  end

  def bs_style?
    options[:bs_style]
  end

  def action_style?
    options[:action_style]
  end

  def color?
    options[:color]
  end

  def size?
    options[:size]
  end

  def tooltip?
    options.key?(:tooltip)
  end

  def tooltip_position?
    options.key?(:tooltip_position)
  end

  chain :inverted do |invert|
    options[:invert] = invert
    @invert_set = true
  end

  chain :with_class do |cls|
    options[:class] = cls
  end

  chain :with_action_style do |cls|
    options[:action_style] = cls
  end

  chain :with_bs_style do |cls|
    options[:bs_style] = cls
  end

  chain :with_size do |size|
    options[:size]
  end

  chain :with_color do |color|
    options[:color]
  end

  chain :with_tooltip do |tooltip|
    options[:tooltip] = tooltip
  end

  chain :with_tooltip_position do |tooltip_position|
    options[:tooltip_position] = tooltip_position
  end

  match do
    @icon = icon
    expected == got
  end

  failure_message_for_should do
    failure_message(false)
  end

  failure_message_for_should_not do
    failure_message(true)
  end

  description do
    # ext = invert? ? "inverted " : ""
    # "render an icon with the #{ext}style: #{icon}"

    desc = "render an iconic icon '#{icon}'"
    descs = []
    descs << "with the Bootstrap style: #{options[:bs_style]}" if bs_style?
    descs << "with the action link style: #{options[:action_style]}" if action_style?
    descs << "with the color: #{options[:color]}" if color?
    descs << "with the size: #{options[:size]}" if size?

    descs << "with the '#{options[:tooltip]}' tooltip" if tooltip?
    descs << "with the '#{options[:tooltip_position]}' tooltip position" if tooltip_position?

    desc << " " if descs.any?
    desc << descs.to_sentence
  end
end