require "spec_helper"

describe RailsBootstrapHelpers::Helpers::ButtonHelper do
  let(:html_attributes) do
    attributes.map{ |k, v| "#{k}=\"#{v}\"" }.join(" ")
  end

  let(:html) { "<a #{html_attributes}>foo</a>" }

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

    context "with custom class attribute" do
      it { should render_bs_button_to("foo").with_class("bar") }
    end

    context "with tooltip" do
      it { should render_bs_button_to("foo").with_tooltip("asd") }
      it { should render_bs_button_to("foo").with_tooltip("asd").with_tooltip_position(:left) }
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

    it "should render a button with a popover" do
      helper.bs_popover_button("foo", "bar").should == html
    end

    context "render popover using block" do
      it "should render a button with a popover" do
        helper.bs_popover_button("foo") { "bar" }.should == html
      end
    end

    context "with custom placement" do
      it "should render a button with a popover" do
        attributes[:"data-placement"] = "top"
        helper.bs_popover_button("foo", "bar", placement: "top").should == html
      end
    end
  end

  describe "bs_collapsible_button" do
    let(:attributes) do
      {
        class: "btn",
        :"data-target" => "bar",
        :"data-toggle" => "collapse",
        name: "button",
        type: "button"
      }
    end

    let(:html) { "<button #{html_attributes}>foo</button>" }

    it "should render a button with a collapsible" do
      helper.bs_collapsible_button("foo", "bar").should == html
    end

    context "with style" do
      it "should render a collapsible button with the proper style" do
        attributes[:class] = "btn btn-primary"
        helper.bs_collapsible_button("foo", "bar", style: "primary").should == html
      end
    end
  end

  describe "button_group" do
    it "should render a button group" do
      content = helper.button_group do
        "asd"
      end

      content.should == '<div class="btn-group">asd</div>'
    end

    context "vertical button group" do
      it "should render a vertical button group" do
        content = helper.button_group vertical: true do
          "asd"
        end

        content.should == '<div class="btn-group btn-group-vertical">asd</div>'
      end
    end

    context "toolbar button group" do
      it "should render a toolbar button group" do
        content = helper.button_group toolbar: true do
          "asd"
        end

        content.should == '<div class="btn-toolbar">asd</div>'
      end
    end
  end
end