require "spec_helper"

describe BootstrapRailsHelpers::Helpers::OptionsHelper do
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
end