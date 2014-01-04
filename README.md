# Schemapper

Schemapper is a database-agnostic tool to visualize [Rails](http://rubyonrails.org/) 3.0+ schemas using [D3](http://d3js.org/).
Schemapper does this by walking your models directly to obtain their associations, table names, and attributes.

## Screen Shot
![Screen Shot](https://raw.github.com/NathanielWroblewski/schemapper/master/screen_shot.png)

## Installation

No need to add schemapper to your Gemfile.  Instead, just install it:

    $ gem install schemapper

## Usage

After installing it, just run the following command from the root of your Rails app:

    $ schemapper

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
