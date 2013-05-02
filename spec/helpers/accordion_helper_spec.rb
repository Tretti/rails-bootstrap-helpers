require "spec_helper"

describe RailsBootstrapHelpers::Helpers::AccordionHelper do
  describe "accordion" do
    it "should render an accordion" do
      expected_html = <<-eos
<div class="accordion" id="foo">
  <div class="accordion-group">
    <div class="accordion-heading">
      <a class="accordion-toggle" data-parent="#foo.accordion" data-toggle="collapse" href="#foo.accordion .accordion-group:nth-child(1) .accordion-body.collapse">
        bar
      </a>
    </div>

    <div class="accordion-body collapse">
      <div class="accordion-inner">
        content
      </div>
    </div>
  </div>
</div>
      eos

      expected_html = expected_html.gsub(/^\s+/, "").gsub("\n", "")

      html = accordion "foo" do |a|
        a.group "bar" do
          "content"
        end
      end

      html.should == expected_html
    end
  end
end