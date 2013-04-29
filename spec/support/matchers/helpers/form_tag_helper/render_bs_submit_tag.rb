RSpec::Matchers.define :render_bs_submit_tag do |text, type|
  def options
    @options ||= { }
  end

  def append_style (style)
    " btn-#{style}"
  end

  def cls
    @cls ||= begin
      cls = "btn"
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
    @render_button_expected ||= "<input class=\"#{cls}\" name=\"commit\" type=\"submit\" value=\"#{text}\" />"
  end

  def got
    @got ||= helper.bs_submit_tag(text, options)
  end

  def failure_message (is_not)
    ex = is_not ? "expected not" : "expected"
    "#{ex}: #{expected}\n     got: #{got}"
  end

  def text
    @text
  end

  def style?
    @style_set
  end

  def size?
    @size_set
  end

  chain :with_style do |style|
    options[:style] = style
    @style_set = true
  end

  chain :with_size do |size|
    options[:size] = size
    @size_set = true
  end

  match do
    @text = text
    @type = type
    expected == got
  end

  failure_message_for_should do
    failure_message(false)
  end

  failure_message_for_should_not do
    failure_message(true)
  end

  description do
    desc = "render a button with type '#{type}'"
    descs = []
    descs << "with the style: #{options[:style]}" if style?
    descs << "with the size: #{options[:size]}" if size?

    desc << " " if descs.any?
    desc << descs.to_sentence(two_words_connector: " and ", last_word_connector: " and ")
  end
end