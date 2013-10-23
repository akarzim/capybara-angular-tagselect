# Capybara::Angular::TagSelect

All this gem does is something very simple- allow you to trigger TagSelect
dropdown to select the value you want. The original select doesn't with the
javascript overrides, so this new helper method does only this thing.


## Installation

Add this line to your application's Gemfile:

    gem 'capybara-angular-tagselect', group: :test

Or, add it into your test group

    group :test do
      gem 'capybara-angular-tagselect'
      ...
    end

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capybara-angular-tagselect

The gem automatically hook itself into rspec helper using Rspec.configure.


## Usage

Just use this method inside your capybara test:

    tag_select("Dropdown Text", from: "Label of the dropdown")

## Known Issues

If many tags match the term you search for, the first match will be used.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
