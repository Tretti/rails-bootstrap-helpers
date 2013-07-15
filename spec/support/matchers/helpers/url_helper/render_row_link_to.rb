RSpec::Matchers.define :render_row_link_to do |text|
  def options
    @options ||= { }
  end

  def cls
    @cls ||= extra_class.present? ? "#{extra_class} rowlink" : "rowlink"
  end

  def html_attributes
    attrs = { href: url, class: cls }

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
    @render_button_expected ||= "<a #{html_attributes}>#{text}</a>"
  end

  def got
    @got ||= helper.row_link_to(text, url, options)
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

  def tooltip?
    options.key?(:tooltip)
  end

  def tooltip_position?
    options.key?(:tooltip_position)
  end

  def extra_class
    options[:class]
  end

  chain :to do |url|
    @url = url
  end

  chain :with_class do |cls|
    options[:class] = cls
  end

  chain :with_tooltip do |tooltip|
    options[:tooltip] = tooltip
  end

  chain :with_tooltip_position do |tooltip_position|
    options[:tooltip_position] = tooltip_position
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
    desc = "render a action link to '#{url}'"
    descs = []

    descs << "with the '#{options[:tooltip]}' tooltip" if tooltip?
    descs << "with the '#{options[:tooltip_position]}' tooltip position" if tooltip_position?

    desc << " " if descs.any?
    desc << descs.to_sentence
  end
end