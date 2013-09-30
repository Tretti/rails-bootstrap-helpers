# -*- encoding : utf-8 -*-

RSpec::Matchers.define :render_bs_alert do |text|
  def options
    @options ||= { }
  end

  def text
    @text
  end

  def cls
    cls = "alert"

    if style? || type?
      style = (options[:style] || options[:type]).to_s

      if style == "notice"
        style = "success"
      end

      unless style == "warning" || style == "default"
        cls << " alert-#{style}"
      end
    end

    if block?
      cls << " alert-block"
    end

    cls
  end

  def expected
    @render_alert_expected ||= begin
      text = self.text

      if dismiss_button?
        text = text + '<button type="button" class="close" data-dismiss="alert">×</button>'
      end

      "<div class=\"#{cls}\">#{text}</div>"
    end
  end

  def got
    @got ||= helper.bs_alert(text, options)
  end

  def failure_message (is_not)
    ex = is_not ? "expected not" : "expected"
    "#{ex}: #{expected}\n     got: #{got}"
  end

  def html_class
    @html_class ||= class? ? @class.to_s : options[:status].to_s
  end

  def style?
    @style_set
  end

  def type?
    @type_set
  end

  def block?
    @block_set
  end

  def dismiss_button?
    @dismiss_button_set
  end

  def class?
    !@class.nil?
  end

  chain :with_style do |style|
    options[:style] = style
    @style_set = true
  end

  chain :with_type do |type|
    options[:type] = type
    @type_set = true
  end

  chain :with_dismiss_button do |dismiss_button|
    options[:dismiss_button] = dismiss_button
    @dismiss_button_set = true
  end

  chain :as_block do |block|
    options[:block] = block
    @block_set = true
  end

  chain :as_class do |cls|
    @class = cls
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
    desc = "render an alert '#{text}'"
    desc << " as block" if block?
    desc << " with dismiss button" if dismiss_button?
    desc << " with the style: #{options[:style]}" if style?
    desc << " with the type: #{options[:type]}" if type?
    desc << " as the class #{html_class}" if class?
    desc
  end
end