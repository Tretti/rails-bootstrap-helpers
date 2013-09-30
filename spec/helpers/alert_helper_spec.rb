require "spec_helper"

describe RailsBootstrapHelpers::Helpers::AlertHelper do
  describe "bs_alert" do
    it { should render_bs_alert("foo") }

    context "with type" do
      it { should render_bs_alert("foo").with_style(:error) }
      it { should render_bs_alert("foo").with_style(:success) }
      it { should render_bs_alert("foo").with_style(:info) }
      it { should render_bs_alert("foo").with_style(:warning) }
      it { should render_bs_alert("foo").with_style(:default) }
      it { should render_bs_alert("foo").with_style(:notice).as_class(:success) }

      context "custom" do
        it { should render_bs_alert("foo").with_style(:bar) }
      end

      context "deprecated options" do
        it { should render_bs_alert("foo").with_type(:error) }
      end
    end

    context "as block" do
      it { should render_bs_alert("foo").as_block(true) }
    end
  end
end