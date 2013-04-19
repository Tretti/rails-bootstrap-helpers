# Bootstrap Rails Helpers

Bootstrap Rails Helpers is a plugin for Ruby on Rails that adds view helpers for
[Bootstrap](http://twitter.github.io/bootstrap/).

## Installation

Add it to your Gemfile:

```ruby
gem "bootstrap-rails-helpers"
```

Manually include the necessary stylesheets and JavaScript files from Bootstrap.

Although it has no direct dependencies on other gems than Rails it is necessary
to include Bootstrap in some way or another to make this gem useful.
[bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass) is
recommended.

### JavaScript

Some of the helpers uses features of Bootstrap that requires JavaScript to be
initialized. You need to manually do this initialization. The following helpers
uses JavaScript that needs manually initialization:

* Any helper with the `:tooltip` option
* bs\_popover\_button

For which JavaScript file to include, follow the
[Bootstrap documentation](http://twitter.github.io/bootstrap/javascript.html).

## Usage

### <a id="common"></a>Common

#### <a id="icon"></a>icon

```ruby
icon :edit # renders an icon with the icon-edit icon
icon :edit, invert: true # inverts the color of the icon, making it white
```

[Bootstrap documentation](http://twitter.github.io/bootstrap/base-css.html#icons)

### <a id="alerts"></a>Alerts

#### <a id="bs_alert"></a>bs\_alert
```ruby
<%= bs_alert "foo" %> # standard alert box
<%= bs_alert "foo", block: true %> # alert box with block style
<%= bs_alert "foo", dismiss_button: true %> # alert box with a dismiss button
```

[Bootstrap documentation](http://twitter.github.io/bootstrap/components.html#alerts)

### <a id="buttons"></a>Buttons

#### <a id="bs_button_to"></a>bs\_button\_to

```ruby
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

```ruby
<%= bs_inline_button_to "http://www.google.se", :edit %>
```

The `bs_inline_button_to` helper renders an `a` tag, styled as a inline
Bootstrap button. That is, a button with the an icon (no text) and the size
"mini". Except from that it accepts all options as the [bs\_button\_to](#bs_button_to) does.

#### <a id="bs_popover_button"></a>bs\_popover\_button

```ruby
<%= bs_popover_button "foo", "bar"
<%= bs_popover_button "foo", "bar", placement: "right"
<%= bs_popover_button "foo" do %>
  <%= link_to "Google", "http://www.google.se" %>
<% end %>
```

Renders a Bootstrap button that when clicked opens a popover. The content of the
popover can either be supplied as the second argument or as a block.

**Note:** this helper requires JavaScript to be manually initialized. Add the
following code to your JavaScript file:

````javascript
$("[data-toggle=popover]").popover(html: true)
```

[Bootstrap documentation](http://twitter.github.io/bootstrap/base-css.html#buttons)

### Forms <a id="forms"></a>

#### <a id="bs_button_tag"></a> bs\_button\_tag

```ruby
<%= bs_button_to "google", :submit %>
```

Renders an `button` tag styled as a Bootstrap button. First argument is the text
to be rendered on the button, the other is what type of button (the is the HTML
attribute `type`). Accepts all the options as [bs\_button\_to](#bs_button_to) does.

[Bootstrap documentation](http://twitter.github.io/bootstrap/base-css.html#buttons)

## Tests

Run the tests using RSpec

	$ bundle install
	$ bundle exec rspec

## License

Bootstrap Rails Helpers is licensed under [The MIT license](http://opensource.org/licenses/MIT)