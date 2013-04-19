module RailsBootstrapHelpers::Helpers::LabelHelper
  include RailsBootstrapHelpers::Helpers::OptionsHelper

  # Renders a Bootstrap label.
  #
  # @param text [String] the text rendered in the label
  # @param style [Symbol, Symbol] the style used to render the label
  # @param options [Hash] a hash of options. Passed straight through to the
  #        underlying "span" tag.
  # 
  def bs_label (text, style = :default, options = {})
    normalize_style = lambda do |style|
      style = style.to_s

      case style
        when "inactive" then "default"
        when "active" then "success"
        when "error" then "important"
      else
        style
      end
    end

    options = options.dup
    style = normalize_style.call(style)

    cls = options[:class]
    cls ||= "label"
    cls << " label-" + style unless style == "default"

    options[:class] = cls

    content_tag :span, text, bs_options(options)
  end
end