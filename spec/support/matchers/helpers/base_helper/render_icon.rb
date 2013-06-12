RSpec::Matchers.define :render_icon do |icon|
  def options
    @options ||= { invert: false }
  end

  def icon
    @icon
  end

  def cls
    cls = "icon-#{icon}"
    cls << " icon-white" if invert?
    cls
  end

  def cls
    @cls ||= begin
      base_class = "icon-#{icon}"
      cls = extra_class.present? ? extra_class + " " + base_class : base_class
      cls << " icon-white" if invert?
      cls
    end
  end

  def expected
    @render_icon_expected ||= "<i class=\"#{cls}\"></i>"
  end

  def got
    @got ||= helper.icon(icon, invert: options[:invert], class: options[:class])
  end

  def failure_message (is_not)
    ex = is_not ? "expected not" : "expected"
    "#{ex}: #{expected}\n     got: #{got}"
  end

  def invert?
    @invert_set
  end

  def extra_class
    options[:class]
  end

  chain :inverted do |invert|
    options[:invert] = invert
    @invert_set = true
  end

  chain :with_class do |cls|
    options[:class] = cls
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
    ext = invert? ? "inverted " : ""
    "render an icon with the #{ext}style: #{icon}"
  end
end