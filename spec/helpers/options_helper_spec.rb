require "spec_helper"

describe RailsBootstrapHelpers::Helpers::OptionsHelper do
  describe "bs_options" do
    context "recognized options" do
      it "should not override unrecognized options" do
        expected = { :"data-toggle" => "bar", title: "text" }
        options = expected.merge tooltip: "foo"
        helper.bs_options(options).should == expected
      end

      context "tooltip" do
        let(:options) do
          { tooltip: "foo" }
        end

        let(:expected) do
          { :"data-toggle" => "tooltip", title: "foo" }
        end

        it "should handle the :tooltip option" do
          helper.bs_options(options).should == expected
        end

        it "should handle the :tooltip_position option" do
          options[:tooltip_position] = "left"
          expected[:"data-placement"] = "left"
          helper.bs_options(options).should == expected
        end

        it "should not handle :tooltip_position if :tooltip is not specified" do
          options.delete(:tooltip)
          options[:tooltip_position] = "left"
          expected[:"data-placement"] = "left"
          helper.bs_options(options).should_not == expected
        end
      end
    end

    context "unrecognized options" do
      it "should leave unrecognized options intact" do
        options = { a: 3, href: "foo", :"data-placement" => "left", title: "foo" }
        helper.bs_options(options).should == options
      end
    end
  end

  describe "append_class!" do
    it "should return the options hash" do
      options = { class: "foo" }
      helper.append_class!(options, "bar").should == options
    end

    context "with non existing class" do
      let(:options) { { } }

      it "should append the given class" do
        helper.append_class!(options, "foo")
        options[:class].should == "foo"
      end

      it "should add a new key, :class, to the options hash" do
        helper.append_class!(options, "foo")
        options.key?(:class).should be_true
      end

      context "when appending multiple classes" do
        let(:classes) { %w[foo bar button small] }

        it "should append all the given classes" do
          helper.append_class!(options, *classes)
          options[:class].should == classes.join(" ")
        end
      end
    end

    context "with existing class" do
      it "should preserve the existing class and append the new" do
        options = { class: "foo" }
        helper.append_class!(options, "bar")
        options[:class].should == "foo bar"
      end

      it "should handle 'class' as a key" do
        options = { "class" => "foo" }
        helper.append_class!(options, "bar")
        options["class"].should == "foo bar"        
      end

      it "should handle :class as key" do
        options = { class: "foo" }
        helper.append_class!(options, "bar")
        options[:class].should == "foo bar"        
      end
    end
  end
end