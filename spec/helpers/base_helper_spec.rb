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

  describe "iconic_icon" do
    it { should render_iconic_icon(:check) }
    it { should render_iconic_icon("clock") }

    context "custom icons" do
      it { should render_iconic_icon(:foo) }
      it { should render_iconic_icon("bar") }
    end

    context "with color" do
      it { should render_iconic_icon(:check).with_color(:blue) }
      it { should render_iconic_icon(:check).with_color('#fff') }
    end

    context "with size" do
      it { should render_iconic_icon(:check).with_size(10) }
      it { should render_iconic_icon(:check).with_size("10") }
      it { should render_iconic_icon(:check).with_size("10px") }
      it { should render_iconic_icon(:check).with_size("1em") }
    end

    context "with Bootstrap style" do
      it { should render_iconic_icon(:check).with_bs_style(:muted) }
      it { should render_iconic_icon(:check).with_bs_style(:success) }
      it { should render_iconic_icon(:check).with_bs_style(:foo) }
    end

    context "with action link style" do
      it { should render_iconic_icon(:check).with_action_style(:default) }
      it { should render_iconic_icon(:check).with_action_style(:success) }
      it { should render_iconic_icon(:check).with_action_style(:foo) }
    end

    context "with tooltip" do
      it { should render_iconic_icon(:check).with_tooltip("foo") }
    end
  end
end