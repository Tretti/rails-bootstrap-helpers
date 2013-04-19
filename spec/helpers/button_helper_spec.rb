require "spec_helper"

describe BootstrapRailsHelpers::Helpers::ButtonHelper do
  describe "bs_button_to" do
    context "with url" do
      it { should render_bs_button_to("foo").to("bar") }
    end
    
    context "with style" do
      it { should render_bs_button_to("foo") }
      it { should render_bs_button_to("foo").with_style(:default) }
      it { should render_bs_button_to("foo").with_style(:primary) }
      it { should render_bs_button_to("foo").with_style(:info) }
      it { should render_bs_button_to("foo").with_style(:success) }
      it { should render_bs_button_to("foo").with_style(:warning) }
      it { should render_bs_button_to("foo").with_style(:danger) }
      it { should render_bs_button_to("foo").with_style(:inverse) }
      it { should render_bs_button_to("foo").with_style(:link) }
    end
    
    context "with size" do
      it { should render_bs_button_to("foo").with_size(:default) }
      it { should render_bs_button_to("foo").with_size(:large) }
      it { should render_bs_button_to("foo").with_size(:small) }
      it { should render_bs_button_to("foo").with_size(:mini) }
    end
    
    context "with icon" do
      it { should render_bs_button_to("foo").with_icon(:ok) }
      it { should render_bs_button_to("foo").with_icon(:edit) }
      it { should render_bs_button_to("foo").with_icon(:none) }
    end

    context "with inverted icon" do
      it { should render_bs_button_to("foo").with_icon(:ok).with_icon_inverted(true) }
      it { should render_bs_button_to("foo").with_icon(:edit).with_icon_inverted(true) }
    end

    context "with icon position" do
      it { should render_bs_button_to("foo").with_icon_position(:default) }
      it { should render_bs_button_to("foo").with_icon_position(:left) }
      it { should render_bs_button_to("foo").with_icon_position(:right) }
    end
  end

  describe "bs_inline_button_to" do
    it { should render_inline_button_to("foo", "edit") }
    
    context "with size" do
      it { should render_inline_button_to("foo", "edit").with_size(:large) }
      it { should render_inline_button_to("foo", "edit").with_size(:small) }
      it { should render_inline_button_to("foo", "edit").with_size(:mini) }
    end
  end

  describe "bs_popover_button" do
    let(:attributes) do
      {
        href: '#',
        class: "btn",
        :"data-content" => "bar",
        :"data-placement" => "bottom",
        :"data-toggle" => "popover"
      }
    end

    let(:html_attributes) do
      attributes.map{ |k, v| "#{k}=\"#{v}\"" }.join(" ")
    end

    it "should render a button with a popover" do
      html = "<a #{html_attributes}>foo</a>"

      helper.bs_popover_button("foo", "bar").should == html
    end

    context "render popover using block" do
      it "should render a button with a popover" do
        html = "<a #{html_attributes}>foo</a>"

        helper.bs_popover_button("foo") { "bar" }.should == html
      end
    end

    context "with custom placement" do
      it "should render a button with a popover" do
        attributes[:"data-placement"] = "top"
        html = "<a #{html_attributes}>foo</a>"

        helper.bs_popover_button("foo", "bar", placement: "top").should == html
      end
    end
  end
end