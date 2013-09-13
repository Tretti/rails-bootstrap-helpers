# Rails Bootstrap Helpers

Rails Bootstrap Helpers is a plugin for Ruby on Rails that adds view helpers for
[Bootstrap](http://getbootstrap.com/2.3.2/). It also contains some helpers
for [Jasny's Bootstrap extensions](http://jasny.github.io/bootstrap/index.html).

This documentation is for the upcoming release, that is git HEAD.
For documentation for the latest release see: https://github.com/Tretti/rails-bootstrap-helpers/blob/v0.0.1/README.md

## Installation

Add it to your Gemfile:

```ruby
gem "rails-bootstrap-helpers"
```

Manually include the necessary stylesheets and JavaScript files from Bootstrap.

Although it has no direct dependencies on other gems than Rails, it is necessary
to include Bootstrap in some way or another to make this gem useful.
For standard Bootstrap, [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass) is
recommended. For Jasny Bootstrap, [jasny-bootstrap-extension-rails](https://github.com/mdedetrich/jasny-bootstrap-extension-rails) is recommended.

### JavaScript

Some of the helpers uses features of Bootstrap that requires JavaScript to be
initialized. You need to manually do this initialization. The following helpers
uses JavaScript that needs manually initialization:

* Any helper with the `:tooltip` option
* [bs\_popover\_button](#bs_popover_button)

For which JavaScript file to include, follow the
[Bootstrap documentation](http://getbootstrap.com/2.3.2/javascript.html).

## Usage

### <a id="common"></a>Common

#### <a id="icon"></a>icon

```erb
<%= icon :edit %> # renders an icon with the icon-edit icon
<%= icon :edit, invert: true %> # inverts the color of the icon, making it white
```

[Bootstrap documentation](http://getbootstrap.com/2.3.2/base-css.html#icons)

#### <a id="iconic_icon"></a>iconic\_icon

```erb
<%= iconic_icon :check %> # renders an icon with the iconic-check icon

<%= iconic_icon :edit, color: :blue %> # render an icon with an CSS color
<%= iconic_icon :edit, color: "#fff" %> # render an icon with an CSS color

<%= iconic_icon :edit, size: 10 %> # render an icon with an CSS font size
<%= iconic_icon :edit, size: "10" %> # render an icon with an CSS font size
<%= iconic_icon :edit, size: "10em" %> # render an icon with an CSS font size

<%= iconic_icon :edit, bs_style: "muted" %> # render an Bootstrap style
<%= iconic_icon :edit, bs_style: "success" %> # render an Bootstrap style

<%= iconic_icon :edit, action_style: "default" %> # render an Jasny Bootstrap action link style
<%= iconic_icon :edit, action_style: "success" %> # render an Jasny Bootstrap action link style
```

Renders an icon using the Jasny Bootstrap Iconic icon set.

[Jasny Bootstrap documentation](http://jasny.github.io/bootstrap/base-css.html#iconic)

### <a id="alerts"></a>Alerts

#### <a id="bs_alert"></a>bs\_alert
```erb
<%= bs_alert "foo" %> # standard alert box
<%= bs_alert "foo", block: true %> # alert box with block style
<%= bs_alert "foo", dismiss_button: true %> # alert box with a dismiss button
```

[Bootstrap documentation](http://getbootstrap.com/2.3.2/components.html#alerts)

### <a id="buttons"></a>Buttons

#### <a id="bs_button_to"></a>bs\_button\_to

```erb
<%= bs_button_to "google", "http://www.google.se" %>
<%= bs_button_to "google", "http://www.google.se", style: "success" %>
<%= bs_button_to "google", "http://www.google.se", disabled: true %>
<%= bs_button_to "google", "http://www.google.se", icon: "edit" %>
<%= bs_button_to "google", "http://www.google.se", icon_position: "left" %>
<%= bs_button_to "google", "http://www.google.se", icon_invert: "left" %>
```

The `bs_button_to` helper renders an `a` tag, styled as a Bootstrap button. It's
basically a wrapper around the `link_to` helper. In addition all the standard
arguments and options that `link_to` accepts it also accepts the above options.

#### <a id="bs_inline_button_to"></a>bs\_inline\_button\_to

```erb
<%= bs_inline_button_to "http://www.google.se", :edit %>
```

The `bs_inline_button_to` helper renders an `a` tag, styled as a inline
Bootstrap button. That is, a button with the an icon (no text) and the size
"mini". Except from that it accepts all options as the [bs\_button\_to](#bs_button_to) does.

#### <a id="bs_popover_button"></a>bs\_popover\_button

```erb
<%= bs_popover_button "foo", "bar" %>
<%= bs_popover_button "foo", "bar", position: "right" %>
<%= bs_popover_button "foo" do %>
  <%= link_to "Google", "http://www.google.se" %>
<% end %>
```

Renders a Bootstrap button that when clicked opens a popover. The content of the
popover can either be supplied as the second argument or as a block.

**Note:** this helper requires JavaScript to be manually initialized. Add the
following code to your JavaScript file:

```javascript
$("[data-toggle=popover]").popover(html: true)
// The "html" option tells the plugin to not escape HTML. Useful when rendering
// the popover content using a block.
```

[Bootstrap documentation](http://getbootstrap.com/2.3.2/base-css.html#buttons)

#### <a id="bs_collapsible_button"></a>bs\_collapsible\_button

```erb
<%= bs_collapsible_button "foo", "#bar" %>
<%= bs_collapsible_button "foo", "#bar", style: "primary" %>

<div id="bar">foobar</div>
```

Renders a Bootstrap button that when clicked will open a collapsible section.
The second argument is a selector matching the section to open.

#### <a id="button_group"></a>button\_group

```erb
<%= button_group do %>
  <%= bs_button_to "google", "http://www.google.se" %>
  <%= bs_button_to "google", "http://www.google.se", style: "success" %>
<% end %>

<%= button_group vertical: true do %>
  <%= bs_button_to "google", "http://www.google.se" %>
  <%= bs_button_to "google", "http://www.google.se", style: "success" %>
<% end %>

<%= button_group toolbar: true do %>
  <%= button_group do %>
    <%= bs_button_to "google", "http://www.google.se" %>
    <%= bs_button_to "google", "http://www.google.se", style: "success" %>
  <% end %>

  <%= button_group do %>
    <%= bs_button_to "google", "http://www.google.se", disabled: true %>
    <%= bs_button_to "google", "http://www.google.se", icon: "edit" %>
  <% end %>
<%= end %>
```

Renders a Bootstrap button group. That is, a div tag with the `btn-group` class.

[Bootstrap documentation](http://getbootstrap.com/2.3.2/components.html#buttonGroups)

#### <a id="bs_dropdown_button_to"></a>bs\_dropdown\_button\_to

Renders a Bootstrap button with a dropdown menu. The menu items are rendered in
the block by rendering list items (`<li>`) with a link (`<a>`) for the menu items.

If the second argument is a string it will render a split button with a dropdown
menu. The second argument will be interpreted as the URL to the left side of the
button. Then the third argument can be used for options.

It accepts all the same options as [bs\_button\_to](#bs_button_to).

Standard button with dropdown menu.

```erb
<%= bs_dropdown_button_to "foo" do %>
  <li><%= link_to "Google", "http://www.google.com" %></li>
  <li><%= link_to "Github", "http://www.github.com" %></li>
<% end %>
```
Split button with a dropdown menu.

```erb
<%= bs_dropdown_button_to "foo", "http://www.google.com" do %>
  <li><%= link_to "Google", "http://www.google.com" %></li>
  <li><%= link_to "Github", "http://www.github.com" %></li>
<% end %>
```

Standard button with dropdown menu and an edit icon.

```erb
<%= bs_dropdown_button_to "foo", icon: "edit" do %>
  <li><%= link_to "Google", "http://www.google.com" %></li>
  <li><%= link_to "Github", "http://www.github.com" %></li>
<% end %>
```

[Bootstrap documentation](http://getbootstrap.com/2.3.2/components.html#buttonDropdowns)

### <a id="forms"></a>Forms

#### <a id="bs_button_tag"></a> bs\_button\_tag

```erb
<%= bs_button_to "google", :submit %>
```

Renders an `button` tag styled as a Bootstrap button. First argument is the text
to be rendered on the button, the other is what type of button (that is, the HTML
attribute `type`). Accepts all the options as [bs\_button\_to](#bs_button_to) does.

[Bootstrap documentation](http://getbootstrap.com/2.3.2/base-css.html#buttons)

#### <a id="bs_submit_tag"></a> bs\_submit\_tag

```erb
<%= bs_submit_tag "save" %>
<%= bs_submit_tag "save", style: "primary" %>
<%= bs_submit_tag "save", size: "small" %>
```

### <a id="labels"></a>Labels

#### <a id="bs_label"></a>bs\_label

```erb
<%= bs_label "foo" # standard label%>
<%= bs_label "foo", :success # styled label %>
```

### <a id="tooltips"></a>Tooltips

```erb
<%= bs_label "foo", tooltip: "bar" %>
```

Basically any helper accepts the `:tooltip` option. This will add a Bootstrap
tooltip to the rendered component.

**Note:** this option requires JavaScript to be manually initialized. Add the
following code to your JavaScript file:

```javascript
$("[data-toggle=tooltip]").tooltip()
```

[Bootstrap documentation](http://getbootstrap.com/2.3.2/components.html#labels-badges)

### <a id="tags"></a>Tags

#### <a id="bs_content_tag"></a>bs\_content\_tag

```ruby
bs_content_tag :div do
  append "foo"
end

bs_content_tag :div, id: "foo" do
  bs_content_tag :div, class: "asd" do
    append "bar"
  end

  append "foobar"
end
```

The above code will return the following HTML code:

```html
<div>
  foo
</div>

<div id="foo">
  <div class="asd">
    bar
  </div>
  foobar
</div>
```

Returns an HTML block. This method behaves basically just like `content_tag` but
properly indents and add newlines to the HTML. This is useful in helpers.

### <a id="accordion"></a>Accordion

#### <a id="accordion_helper"></a>accordion

```erb
<%= accordion "unique_id" do |a| %>
  <% a.group "heading" do %>
    content
  <% end %>
<% end %>
```

The above code will render the following HTML code:

```html
<div class="accordion" id="unique_id">
  <div class="accordion-group">
    <div class="accordion-heading">
      <a class="accordion-toggle" data-parent="#unique_id.accordion" data-toggle="collapse" href="#unique_id.accordion .accordion-group:nth-child(0) .accordion-body.collapse">
        heading
      </a>
    </div>

    <div class="accordion-body collapse">
      <div class="accordion-inner">
        content
      </div>
    </div>
  </div>
</div>
```

Renders a Bootstrap accordion/collapsible section.

[Bootstrap documentation](http://getbootstrap.com/2.3.2/javascript.html#collapse)

### <a id="accordion"></a>Url Helpers

#### <a id="action_link_to"></a>action\_link\_to

```erb
<%= action_link_to "google", "http://www.google.se" %>
<%= action_link_to "google", "http://www.google.se", style: "default" %>
<%= action_link_to "google", "http://www.google.se", style: "primary" %>
```

Renders an action link from Jasny's Bootstrap extensions. It's basically a
wrapper around the `link_to` helper. In addition all the standard arguments and
options that `link_to` accepts it also accepts the above options.

[Jasny Bootstrap documentation](http://jasny.github.io/bootstrap/base-css.html#action-links)

#### <a id="action_link_to"></a>row\_link\_to

```erb
<%= row_link_to "google", "http://www.google.se" %>
```

Renders a row link from Jasny's Bootstrap extensions. It's basically a
wrapper around the `link_to` helper.

[Jasny Bootstrap documentation](http://jasny.github.io/bootstrap/javascript.html#rowlink)

### <a id="navigation"></a>Navigation

#### <a id="tabbable"></a>tabbable

Renders a tabbable navigation. By default the first tab will be active. This is
possible to override by passing `active: true` or `active: false` to any tab
or tab pane. If `active: false` is specified to any tab or tab pane the first
tab or tab pane will _not_ get the class "active".

```erb
<%= tabbable do |bar| %>
  <% bar.tab "foo" %>
  <% bar.tab "bar" %>

  <% bar.tab_pane do %>
    Foo pane
  <% end %>

  <% bar.tab_pane do %>
    Bar pane
  <% end %>
<% end >
```

The above code will render the following HTML:

```html
<div class="tabbable">
  <ul class="nav nav-tabs">
    <li class="active"><a href="#tab_pane_0_2156227680" data-toggle="tab">foo</a></li>
    <li><a href="#tab_pane_1_2156227620" data-toggle="tab">bar</a></li>
  </ul>

  <div class="tab-content">
    <div class="active" id="tab_pane_0_2156227680">
      foo content
    </div>

    <div id="tab_pane_1_2156227620">
      bar content
    </div>
  </div>
</div>
```

Alternatively the tabs can be passed directly to the `tabbable` method:

```erb
<%= tabbable "foo", "bar" do |bar| %>
  <% bar.tab_pane do %>
    Foo pane
  <% end %>

  <% bar.tab_pane do %>
    Bar pane
  <% end %>
<% end >
```

If the number of tabs and tab panes don't match an error will be raised.

```erb
<%= tabbable "foo", fade: true do |bar| %>
  <% bar.tab_pane do %>
    Foo pane
  <% end %>
<% end >
```

The above option will add the "fade in" class to each tab pane. Requires the
bootstrap-transition.js file to work.

```erb
<%= tabbable do |bar| %>
  <% bar.tab "foo" %>
  <% bar.tab "bar", active: true %>

  <% bar.tab_pane do %>
    Foo pane
  <% end %>

  <% bar.tab_pane active: true do %>
    Bar pane
  <% end %>
<% end >
```

The above will add the class "active" only to the tabs and tab panes with the
option `active: true`.

```erb
<%= tabbable "foo", bordered: true do |bar| %>
  <% bar.tab_pane do %>
    Foo pane
  <% end %>
<% end >
```

The above option will render the tabbable container with a border. Requires
the Jasny Bootstrap extensions.

Add the option `direction`, with the value `"top"`, `"left"`, `"right"` or
`"below"`, to render the tabs in the direction specified.

[Bootstrap documentation](http://getbootstrap.com/2.3.2/components.html#navs)
[Jasny Bootstrap documentation](http://jasny.github.io/bootstrap/components.html#navs)

## Tests

Run the tests using RSpec

	$ bundle install
	$ bundle exec rspec

## License

Rails Bootstrap Helpers is licensed under [The MIT license](http://opensource.org/licenses/MIT)