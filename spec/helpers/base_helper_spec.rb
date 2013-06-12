require "spec_helper"

describe RailsBootstrapHelpers::Helpers::BaseHelper do
  describe "icon" do
    it { should render_icon(:edit) }
    it { should render_icon("remove") }

    context "with invert icon" do
      it { should render_icon(:edit).inverted(true) }
      it { should render_icon("remove").inverted(true) }
    end

    context "custom icons" do
      it { should render_icon(:foo) }
      it { should render_icon("bar") }
    end

    context "with class" do
      it { should render_icon(:edit).with_class("bar") }
      it { should render_icon("remove").with_class("bar") }
      it { should render_icon(:edit).inverted(true).with_class("bar") }
    end
  end
end