require "spec_helper"

describe BootstrapRailsHelpers::Helpers::LabelHelper do
  describe "bs_label" do
    it { should render_bs_label("foo") }
    it { should render_bs_label("foo").with_style(:success) }
    it { should render_bs_label("foo").with_style(:warning) }
    it { should render_bs_label("foo").with_style(:important) }
    it { should render_bs_label("foo").with_style(:info) }
    it { should render_bs_label("foo").with_style(:inverse) }

    context "custom statuses" do
      it { should render_bs_label("foo").with_style(:active).as_class("success") }
      it { should render_bs_label("foo").with_style(:inactive).as_class("default") }
      it { should render_bs_label("foo").with_style(:error).as_class("important") }
    end

    context "with tooltip" do
      it { should render_bs_label("foo").with_tooltip("bar") }
      it { should render_bs_label("foo").with_tooltip("bar").with_tooltip_position(:left) }
    end
  end
end