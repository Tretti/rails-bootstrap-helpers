require "spec_helper"

describe RailsBootstrapHelpers::Helpers::AlertHelper do
  describe "bs_alert" do
    it { should render_bs_alert("foo") }

    context "with type" do
      it { should render_bs_alert("foo").with_type(:error) }
      it { should render_bs_alert("foo").with_type(:success) }
      it { should render_bs_alert("foo").with_type(:info) }
      it { should render_bs_alert("foo").with_type(:warning) }
      it { should render_bs_alert("foo").with_type(:default) }
      it { should render_bs_alert("foo").with_type(:notice).as_class(:success) }

      context "custom" do
        it { should render_bs_alert("foo").with_type(:bar) }
      end
    end

    context "as block" do
      it { should render_bs_alert("foo").as_block(true) }
    end
  end
end