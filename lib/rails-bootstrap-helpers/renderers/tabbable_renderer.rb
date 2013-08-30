# <div class="tabbable" id="foo">
#   <ul class="nav nav-tabs">
#     <li><a href="#{foo_tab_id}">foo</a></li>
#     <li><a href="#{bar_tab_id}">bar</a></li>
#   </ul>
# 
#   <div class="tab-content">
#     <div id="#{foo_tab_id}">
#       foo content
#     </div>
# 
#     <div id="#{bar_tab_id}">
#       bar content
#     </div>
#   </div>
# </div>

module RailsBootstrapHelpers::Renderers
  class TabbableRenderer < Renderer
    def initialize (template, *args, &block)
      super template
      @args = args || []
      @block = block

      @options = {}
      @tabs = []
      @panes = []

      @last_id = 0
      @ids = []
    end

    def render
      befor_block
        block.call TabContext.new(self)
      after_block
    end

    def add_tab (text, options)
      @tabs << Tab.new(text, options)
    end

    def add_pane (block, options)
      @panes << Pane.new(block, options)
    end

  private

    attr_reader :args
    attr_reader :tabs
    attr_reader :panes
    attr_reader :block
    attr_reader :options
    attr_accessor :ids

    def active_tabs?
      @active_tabs
    end

    def active_panes?
      @active_panes
    end

    def befor_block
      extract_options!
      collect_tabs
    end

    def after_block
      match_tabs_with_panes!
      identify_active_tabs
      identify_active_panes

      render_tabbable
    end

    def extract_options!
      if args.last.is_a?(Hash)
        @options = args.last
        @tabs = args[0 ... -1]
      else
        @tabs = args
      end
    end

    def collect_tabs
      @tabs = @tabs.map { |text| Tab.new(text, {}) }
    end

    def identify_active_tabs
      @active_tabs = tabs.any? { |tab| tab.options.key?(:active) }
    end

    def identify_active_panes
      @active_panes = panes.any? { |pane| pane.options.key?(:active) }
    end

    def match_tabs_with_panes!
      tab_text = pluralize(tabs.length, "tab")
      pane_text = pluralize(panes.length, "pane")

      tab_was = tabs.length == 1 ? "was" : "were"
      pane_was = panes.length == 1 ? "was" : "were"

      if tabs.length != panes.length
        raise "Unmatching tabs and panes. #{tab_text} #{tab_was} given and #{pane_text} #{pane_was} given"
      end
    end

    def render_tabbable
      cls = "tabbable"
      cls << " tabbable-bordered" if options[:bordered]

      content_tag :div, class: cls do
        render_tabs + "\n" +
        render_tab_content
      end
    end

    def render_tabs
      content_tag :ul, class: "nav nav-tabs" do
        content = process_tab(tabs.first, !active_tabs?) + "\n"
        content << tabs[1 .. -1].map { |tab| process_tab(tab) }.join("\n").html_safe
      end
    end

    def process_tab (tab, active = false)
      @ids << id_for_tab(tab.name)
      render_tab(ids.last, tab, active)
    end

    def render_tab_content
      content_tag :div, class: "tab-content" do
        content = render_tab_pane(ids.first, panes.first, !active_panes?) + "\n"

        panes = @panes[1 .. -1]
        ids = @ids[1 .. -1]

        content << panes.zip(ids).map { |pane, id| render_tab_pane(id, pane) }.join("\n").html_safe
      end
    end

    def render_tab (id, tab, active = false)
      if tab.options.key?(:active)
        active = tab.options[:active]
      end

      content_tag :li, class: ("active" if active) do
        link_to tab.name, "##{id}", data: { toggle: "tab" }
      end
    end

    def render_tab_pane (id, pane, active = false)
      if pane.options.key?(:active)
        active = pane.options[:active]
      end

      cls = "tab-pane"
      cls << " active" if active
      cls << " fade in" if options[:fade]
      content_tag :div, id: "#{id}", class: cls, &pane.block
    end

    def id_for_tab (name)
      id = "tab_pane_#{@last_id}_#{name.object_id}"
      @last_id += 1
      id
    end

    class TabContext
      def initialize (renderer)
        @renderer = renderer
      end

      def tab (text, options = {})
        @renderer.add_tab(text, options)
      end

      def tab_pane (options = {}, &block)
        @renderer.add_pane(block, options)
      end

    private

      attr_reader :renderer
    end

    Tab = Struct.new(:name, :options)
    Pane = Struct.new(:block, :options)
  end
end