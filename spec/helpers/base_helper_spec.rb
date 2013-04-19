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
  end
end