require "spec_helper"

describe BootstrapRailsHelpers::Helpers::AlertHelper do
  describe "alert" do
    it { should render_alert_box("foo") }

    context "with type" do
      it { should render_alert_box("foo").with_type(:error) }
      it { should render_alert_box("foo").with_type(:success) }
      it { should render_alert_box("foo").with_type(:info) }
      it { should render_alert_box("foo").with_type(:warning) }
      it { should render_alert_box("foo").with_type(:default) }
      it { should render_alert_box("foo").with_type(:notice).as_class(:success) }

      context "custom" do
        it { should render_alert_box("foo").with_type(:bar) }
      end
    end

    context "as block" do
      it { should render_alert_box("foo").as_block(true) }
    end
  end
end