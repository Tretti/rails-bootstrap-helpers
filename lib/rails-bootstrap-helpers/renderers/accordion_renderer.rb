module RailsBootstrapHelpers::Renderers
  class AccordionRenderer < Renderer
    def initialize (template, id, &block)
      super template
      @id = id
      @block = block
      @selector = Selector.new
    end

    def render
      @context = AccordionContext.new(self)
      block.call(context)
      build_accordion
    end

  private
    attr_reader :id
    attr_reader :block
    attr_reader :selector
    attr_reader :context

    def build_accordion
      content_tag :div, id: id, class: "accordion" do
        contents = []
        selector.base "##{id}.accordion" do |base|
          context.groups.each_with_index do |group, count|
            contents << build_group(group, count, base)
          end
        end

        contents.join("\n").html_safe
      end
    end

    def build_group (group, count, accordion_base)
      base = "accordion-group"

      selector.base ".#{base}" do |group_base|
        foobar = self
        content_tag(:div, class: base) do
          body = "accordion-body"
          build_heading(group.heading, body, count, accordion_base, group_base, random_id) +
          build_body(body, group.block, random_id)
        end
      end
    end

    def build_heading (heading, body, count, accordion_base, group_base, random_id)
      href = "##{random_id}"

      content_tag :div, class: "accordion-heading" do
        content_tag :a, heading,
          href: href,
          class: "accordion-toggle",
          :"data-toggle" => "collapse",
          :"data-parent" => accordion_base
      end
    end

    def build_body (body, block, random_id)
      content_tag :div, class: body + " collapse", id: random_id do
        content_tag :div, class: "accordion-inner", &block
      end
    end

    class AccordionContext
      Group = Struct.new(:heading, :block)

      attr_reader :groups

      def initialize (renderer)
        @renderer = renderer
        @groups = []
      end

      def group (heading, &block)
        @groups << Group.new(heading, block)
      end
    end

    class Selector
      def initialize
        @base = []
      end

      def base (base, &block)
        @base << base
        block.call @base.join(" ")
      ensure
        @base.pop
      end
    end
  end
end
