RSpec::Matchers.define :render_bs_button_to do |text|
  def options
    @options ||= { }
  end

  def append_style (style)
    " btn-#{style}"
  end

  def cls
    @cls ||= begin
      cls = extra_class.present? ? "#{extra_class} btn" : "btn"
      cls << " btn-#{options[:style]}" if style?
      cls << " btn-#{options[:size]}" if size?
      cls
    end
  end

  def text_with_icon
    if icon?
      cls = "icon-#{options[:icon]}"
      cls << " icon-white" if inverted?
      icon = "<i class=\"#{cls}\"></i>"
      default = icon + " " + text

      if icon_position?
        if options[:icon_position].to_s == "right"
          return text + " " + icon
        end
      end

      default
    else
      text
    end
  end

  def expected
    @render_button_expected ||= "<a href=\"#{url}\" class=\"#{cls}\">#{text_with_icon}</a>"
  end

  def got
    @got ||= helper.bs_button_to(text, url, options)
  end

  def failure_message (is_not)
    ex = is_not ? "expected not" : "expected"
    "#{ex}: #{expected}\n     got: #{got}"
  end

  def text
    @text
  end

  def url
    @url || "default_url"
  end

  def style?
    @style_set
  end

  def size?
    @size_set
  end

  def icon?
    @icon_set
  end

  def inverted?
    @inverted_set
  end

  def icon_position?
    @icon_position_set
  end

  def extra_class
    options[:class]
  end

  chain :to do |url|
    @url = url
  end

  chain :with_style do |style|
    options[:style] = style
    @style_set = true
  end

  chain :with_size do |size|
    options[:size] = size
    @size_set = true
  end

  chain :with_icon do |icon|
    options[:icon] = icon
    @icon_set = true
  end

  chain :with_icon_inverted do |inverted|
    options[:icon_invert] = inverted
    @inverted_set = true
  end

  chain :with_icon_position do |icon_position|
    options[:icon_position] = icon_position
    @icon_position_set = true
  end

  chain :with_class do |cls|
    options[:class] = cls
  end

  match do
    @text = text
    expected == got
  end

  failure_message_for_should do
    failure_message(false)
  end

  failure_message_for_should_not do
    failure_message(true)
  end

  description do
    desc = "render a button to '#{url}'"
    descs = []
    descs << "with the style: #{options[:style]}" if style?
    descs << "with the size: #{options[:size]}" if size?

    ext = inverted? ? "inverted " : ""

    descs << "with the #{ext}icon: #{options[:icon]}" if icon?
    descs << "with the icon_position: #{options[:icon_position]}" if icon_position?

    desc << " " if descs.any?
    desc << descs.to_sentence
  end
end