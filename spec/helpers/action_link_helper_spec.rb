require "spec_helper"

describe RailsBootstrapHelpers::Helpers::ActionLinkHelper do
  describe "action_link_to" do
    context "with url" do
      it { should render_action_link_to("foo").to("bar") }
    end

    context "with style" do
      it { should render_action_link_to("foo") }
      it { should render_action_link_to("foo").with_style(:default).with_class("asd") }
      it { should render_action_link_to("foo").with_style(:primary) }
      it { should render_action_link_to("foo").with_style(:info) }
      it { should render_action_link_to("foo").with_style(:success) }
      it { should render_action_link_to("foo").with_style(:warning) }
      it { should render_action_link_to("foo").with_style(:danger) }
    end

    context "with tooltip" do
      it { should render_action_link_to("foo").with_tooltip("asd") }
      it { should render_action_link_to("foo").with_tooltip("asd").with_tooltip_position(:left) }
    end
  end
end