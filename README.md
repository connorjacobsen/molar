# Molar

Molar dynamically defines attribute hash getters and setters for your classes.

*Work in progress*

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'molar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install molar

## Usage

```ruby
class Jedi
  include Molar

  def initialize(attributes = {})
    @attributes = attributes
  end
end

jedi = Jedi.new(name: 'Luke Skywalker', master: 'Yoda')

jedi.name
# => 'Luke Skywalker'

jedi.master
# => 'Yoda'

jedi.name = 'Anakin'
jedi.name
# => 'Anakin'
```

Molar defines accessors and setters on the fly so as not to incur the `:method_missing` penalty on each access. Currently, only lookups in the `@attributes` instance variable are supported.

Currently, mutation coverage is `~77%`, but I haven't yet had a chance to determine how meaningful that is, as this gem uses a couple of items listed under the limitations section for [mutant](https://github.com/mbj/mutant) (which is a great tool, by the way).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/connorjacobsen/molar.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
