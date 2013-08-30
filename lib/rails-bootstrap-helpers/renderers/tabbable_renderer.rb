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
      extract_options!
      block.call TabContext.new(self)
      match_tabs_with_panes!
      render_tabbable
    end

    def add_tab (text)
      @tabs << text
    end

    def add_pane (block)
      @panes << block
    end

  private

    attr_reader :args
    attr_reader :tabs
    attr_reader :panes
    attr_reader :block
    attr_reader :options
    attr_accessor :ids

    def extract_options!
      if args.last.is_a?(Hash)
        @options = args.last
        @tabs = args[0 ... -1]
      else
        @tabs = args
      end
    end

    def match_tabs_with_panes!
      tab_text = pluralize(tabs.length, "tab")
      pane_text = pluralize(panes.length, "pane")

      if tabs.length != panes.length
        raise "Unmatching tabs and panes. #{tab_text} were given and #{pane_text} was given"
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
        tabs.map do |name|
          @ids << id_for_tab(name)
          render_tab(ids.last, name, false)
        end.join("\n").html_safe
      end
    end

    def render_tab_content
      content_tag :div, class: "tab-content" do
        panes.zip(ids).map { |block, id| render_tab_pane(id, block) }.join("\n").html_safe
      end
    end

    def render_tab (id, name, active = false)
      content_tag :li, class: ("active" if active) do
        link_to name, "##{id}"
      end
    end

    def render_tab_pane (id, block)
      content_tag :div, id: "##{id}", &block
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

      def tab (text)
        @renderer.add_tab(text)
      end

      def tab_pane (&block)
        @renderer.add_pane(block)
      end

    private

      attr_reader :renderer
    end
  end
end