module RailsBootstrapHelpers::Renderers
  class ButtonRenderer < AbstractButtonRenderer
    def render
      append_class "btn"

      if style = has_option?("style")
        append_class "btn-" + style.to_s
      end

      if size = has_option?("size")
        append_class "btn-" + size.to_s
      end

      if disabled = has_option?("disabled")
        append_class "disabled"
      end

      if icon = has_option?("icon")
        pos = has_option?("icon_position")
        icon_args = [icon, invert: has_option?("icon_invert")]

        if pos.to_s == "right"
          self.text = self.text.to_s + " " + RailsBootstrapHelpers::Helpers::BaseHelper.icon(*icon_args)
        else
          self.text = RailsBootstrapHelpers::Helpers::BaseHelper.icon(*icon_args) + " " + self.text.to_s
        end

        self.text = self.text.html_safe
      else
        strip_unused_options!
      end

      super
    end

  private

    def strip_unused_options!
      has_option?("icon_position")
      has_option?("icon_invert")
    end
  end
end