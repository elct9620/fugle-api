Fugle API
===

This is Ruby gem implement Realtime API client for [Fugle.tw](https://fugle.tw)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fugle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fugle

## Usage

Currently only support HTTP API as below, for better use the API the result structure is modified.

### Config

```ruby
Fugle.config do |c|
  c.api_token = 'XXX'
end
```

> The token also loaded from `FUGLE_API_TOKEN` environment variable

You can temporary change config by `Fugle.use`

```ruby
config = Fugle::Config.new(api_token: 'XXX')

Fugle.use(config) do
  Fugle.intraday.meta(symbol: '0050')
end
```

### Chart

```ruby
Fugle.intraday.chart(symbol: '0050').body.each do |item|
  puts "Open: #{item.open} @ #{item.time}"
end
```

### Quote

```ruby
Fugle.intraday.quote(symbol: '0050').body.closed?
```

### Meta

```ruby
Fugle.intraday.meta(symbol: '0050').body.name
```

### Trades

```ruby
Fugle.intraday.trades(symbol: '0050').body.each do |item|
  puts "Price: #{item.price}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/fugle-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Fugle project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elct9620/fugle-api/blob/master/CODE_OF_CONDUCT.md).
