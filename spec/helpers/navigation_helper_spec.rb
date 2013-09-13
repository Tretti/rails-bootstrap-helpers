require "spec_helper"

describe RailsBootstrapHelpers::Helpers::NavigationHelper do
  let(:foo_tab_text) { "foo" }
  let(:bar_tab_text) { "bar" }

  let(:foo_tab_id) { "tab_pane_0_#{foo_tab_text.object_id}" }
  let(:bar_tab_id) { "tab_pane_1_#{bar_tab_text.object_id}" }

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
    <li class="active"><a href="##{foo_tab_id}" data-toggle="tab">foo</a></li>
    <li><a href="##{bar_tab_id}" data-toggle="tab">bar</a></li>
  </ul>

  <div class="tab-content">
    <div class="tab-pane active" id="#{foo_tab_id}">
      foo content
    </div>

    <div class="tab-pane" id="#{bar_tab_id}">
      bar content
    </div>
  </div>
</div>
  eos

    strip_expected(html)
  end

  describe "tabbable" do
    it "should render an tabbable navigation" do
      html = tabbable(foo_tab_text, &block)
      strip(html).should == expected_html
    end

    context "unmatching tabs and panes" do
      let(:errro_message) { "Unmatching tabs and panes. 0 tabs were given and 1 pane was given" }

      it "should raise an unmatching error" do
        ->() { tabbable { |bar| bar.tab_pane { "foo" } } }.should raise_error(errro_message)
      end
    end

    context "options" do
      context "with bordered style" do
        let(:html_class) { "tabbable tabbable-bordered" }

        it "should render a tabbable navigation with a border" do
          html = tabbable(foo_tab_text, bordered: true, &block)
          strip(html).should == expected_html
        end
      end

      context "with fade" do
        let(:expected_html) do
          html = <<-eos
<div class="tabbable">
  <ul class="nav nav-tabs">
    <li class="active"><a href="##{foo_tab_id}" data-toggle="tab">foo</a></li>
    <li><a href="##{bar_tab_id}" data-toggle="tab">bar</a></li>
  </ul>

  <div class="tab-content">
    <div class="tab-pane active fade in" id="#{foo_tab_id}">
      foo content
    </div>

    <div class="tab-pane fade in" id="#{bar_tab_id}">
      bar content
    </div>
  </div>
</div>
          eos

          strip_expected(html)
        end

        it "should render a tabbable navigation with fade" do
          html = tabbable(foo_tab_text, fade: true, &block)
          strip(html).should == expected_html
        end
      end

      context "with active" do
        it "should render the specified tabs and tab panes as active" do
          expected_html = <<-eos
<div class="tabbable">
  <ul class="nav nav-tabs">
    <li><a href="##{foo_tab_id}" data-toggle="tab">foo</a></li>
    <li class="active"><a href="##{bar_tab_id}" data-toggle="tab">bar</a></li>
  </ul>

  <div class="tab-content">
    <div class="tab-pane" id="#{foo_tab_id}">
      foo content
    </div>

    <div class="tab-pane active" id="#{bar_tab_id}">
      bar content
    </div>
  </div>
</div>
          eos

          expected_html = strip_expected(expected_html)

          html = tabbable do |bar|
            bar.tab foo_tab_text
            bar.tab bar_tab_text, active: true

            bar.tab_pane do
              "foo content"
            end

            bar.tab_pane active: true do
              "bar content"
            end
          end

          strip(html).should == expected_html
        end

        it "should render none of the tabs or tab panes as active if ':active' is set to 'false'" do
          expected_html = <<-eos
<div class="tabbable">
  <ul class="nav nav-tabs">
    <li><a href="##{foo_tab_id}" data-toggle="tab">foo</a></li>
    <li><a href="##{bar_tab_id}" data-toggle="tab">bar</a></li>
  </ul>

  <div class="tab-content">
    <div class="tab-pane" id="#{foo_tab_id}">
      foo content
    </div>

    <div class="tab-pane" id="#{bar_tab_id}">
      bar content
    </div>
  </div>
</div>
          eos

          expected_html = strip_expected(expected_html)

          html = tabbable do |bar|
            bar.tab foo_tab_text
            bar.tab bar_tab_text, active: false

            bar.tab_pane do
              "foo content"
            end

            bar.tab_pane active: false do
              "bar content"
            end
          end

          strip(html).should == expected_html
        end
      end

      context "with direction" do
        context "unspecified" do
          let(:html_class) { "tabbable" }

          it "should render a tabbable navigation with the tabs on top" do
            html = tabbable(foo_tab_text, &block)
            strip(html).should == expected_html
          end
        end

        context "top" do
          let(:html_class) { "tabbable" }

          it "should render a tabbable navigation with the tabs on top" do
            html = tabbable(foo_tab_text, direction: "top", &block)
            strip(html).should == expected_html
          end
        end

        context "bottom" do
          let(:html_class) { "tabbable tabs-below" }

          it "should render a tabbable navigation with the tabs on the bottom" do
            html = tabbable(foo_tab_text, direction: "below", &block)
            strip(html).should == expected_html
          end
        end

        context "left" do
          let(:html_class) { "tabbable tabs-left" }

          it "should render a tabbable navigation with the tabs on the left" do
            html = tabbable(foo_tab_text, direction: "left", &block)
            strip(html).should == expected_html
          end
        end

        context "right" do
          let(:html_class) { "tabbable tabs-right" }

          it "should render a tabbable navigation with the tabs on the right" do
            html = tabbable(foo_tab_text, direction: "right", &block)
            strip(html).should == expected_html
          end
        end
      end
    end
  end
end