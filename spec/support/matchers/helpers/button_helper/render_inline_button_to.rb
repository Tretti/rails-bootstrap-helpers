RSpec::Matchers.define :render_inline_button_to do |url, icon|
  def options
    @options ||= { size: "mini" }
  end

  def cls
    @cls ||= "btn btn-#{options[:size]}"
  end

  def text_with_icon
    "<i class=\"icon-#{icon}\"></i> "
  end

  def attributes
    attrs = {
      href: url,
      class: cls
    }

    attrs = attrs.map do |k, v|
      "#{k}=\"#{v}\""
    end

    attrs.join(" ")
  end

  def expected
    @render_remove_button_expected ||= "<a #{attributes}>#{text_with_icon}</a>"
  end

  def got
    @got ||= helper.bs_inline_button_to(url, icon, options)
  end

  def failure_message (is_not)
    ex = is_not ? "expected not" : "expected"
    "#{ex}: #{expected}\n     got: #{got}"
  end

  def url
    @url
  end

  def icon
    @icon
  end

  def size?
    @size_set
  end

  chain :with_size do |size|
    options[:size] = size
    @size_set = true
  end

  match do
    @url = url
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
    desc = "render an inline button to '#{url}' with the icon: #{icon}"
    descs = []
    descs << "with the size: #{options[:size]}" if size?

    desc << " " if descs.any?
    desc << descs.to_sentence(two_words_connector: " and ", last_word_connector: " and ")
  end
end