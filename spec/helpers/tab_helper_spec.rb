require "spec_helper"

describe RailsBootstrapHelpers::Helpers::NavigationHelper do
  def strip (html)
    html.gsub!("\n", "")
  end

  let(:foo_tab_text) { "foo" }
  let(:bar_tab_text) { "bar" }

  let(:foo_tab_id) { "#tab_pane_0_#{foo_tab_text.object_id}" }
  let(:bar_tab_id) { "#tab_pane_1_#{bar_tab_text.object_id}" }

  let(:block) do
    lambda do |bar|
      bar.tab bar_tab_text

      bar.tab_pane do
        "foo content"
      end

      bar.tab_pane do
        "bar content"
      end
    end
  end

  let(:html_class) { "tabbable" }
  let(:expected_html) do
    html = <<-eos
<div class="#{html_class}">
<ul class="nav nav-tabs">
  <li><a href="#{foo_tab_id}">foo</a></li>
  <li><a href="#{bar_tab_id}">bar</a></li>
</ul>

<div class="tab-content">
  <div id="#{foo_tab_id}">
    foo content
  </div>

  <div id="#{bar_tab_id}">
    bar content
  </div>
</div>
</div>
eos

    html.gsub(/^\s+/, "").gsub("\n", "")
  end

  describe "tabbable" do
    it "should render an tabbable navigation" do
      html = tabbable(foo_tab_text, &block)
      strip(html).should == expected_html
    end

    context "with bordered style" do
      let(:html_class) { "tabbable tabbable-bordered" }

      it "should render a tabbable navigation with a border" do
        html = tabbable(foo_tab_text, bordered: true, &block)
        strip(html).should == expected_html
      end
    end
  end
end