require "spec_helper"

describe RailsBootstrapHelpers::Helpers::TagHelper do
  describe "bs_content_tag" do
    it "should render an HTML tag" do
      expected_html = <<-eos
<div id="foo">
  <div>
    foo
  </div>
  bar
</div>
      eos

      html = bs_content_tag :div, id: "foo" do
        bs_content_tag :div do
          append "foo"
        end

        append "bar"
      end

      html.should == expected_html
    end
  end
end