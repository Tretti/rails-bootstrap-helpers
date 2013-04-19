RSpec::Matchers.define :render_bs_label do |text|
  def options
    @options ||= { }
  end

  def style
    @style
  end

  def style?
    @style.present?
  end

  def custom_class
    @custom_class
  end

  def custom_class?
    @custom_class.present?
  end

  def tooltip?
    options.key?(:tooltip)
  end

  def tooltip_position?
    options.key?(:tooltip_position)
  end

  def text
    @text
  end

  def html_cls
    @html_cls ||= custom_class? ? custom_class.to_s : style.to_s
  end

  def build_html_class
    "label".tap do |c|
      c << " label-#{html_cls}" unless html_cls == "default"
    end
  end

  def html_attributes
    attrs = { class: build_html_class }

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
    @render_bs_label_expected ||= begin
      "<span #{html_attributes}>#{text}</span>"
    end
  end

  def got
    @got ||= helper.bs_label(text, style, options)
  end

  def failure_message (is_not)
    ex = is_not ? "expected not" : "expected"
    "#{ex}: #{expected}\n     got: #{got}"
  end

  chain :with_style do |style|
    @style = style
  end

  chain :as_class do |custom_class|
    @custom_class = custom_class
  end

  chain :with_tooltip do |tooltip|
    options[:tooltip] = tooltip
  end

  chain :with_tooltip_position do |tooltip_position|
    options[:tooltip_position] = tooltip_position
  end

  match do
    @text = text
    @style ||= "default"
    expected == got
  end

  failure_message_for_should do
    failure_message(false)
  end

  failure_message_for_should_not do
    failure_message(true)
  end

  description do
    desc = "should return a label with the text '#{text}' and with the #{style} style"
    desc << " as the class #{html_cls}" if custom_class?
    descs = []
    descs << "with the '#{options[:tooltip]}' tooltip" if tooltip?
    descs << "with the '#{options[:tooltip_position]}' tooltip position" if tooltip_position?

    desc << " " if descs.any?
    desc << descs.to_sentence(two_words_connector: " and ", last_word_connector: " and ")
  end
end